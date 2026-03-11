//
//  TimerViewModel.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 04.03.2026.
//

import Foundation
import SwiftData

@Observable
final class TimerViewModel {
    
    private var modelContext: ModelContext?
    var selectedActivity: Activity = .example
    let activities: [Activity] = Activity.examples
    var selectedQuality: TimeQuality = .deep
    private var systemTimer: Timer?
    private(set) var currentBlock: WorkBlock?
    private(set) var sessionDuration: TimeInterval = 2
    private(set) var endDate: Date?
    private(set) var remainingTimeAtPause: Double?
    private(set) var timerState: TimerState = .idle
    private(set) var remaining : TimeInterval = 0
    private let userDefaults = UserDefaults.standard
    private let notificationService: NotificationService = NotificationService()
    private var overTimeStartDate: Date? = nil
    var overTimeDuration: TimeInterval = 0
    
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()
    
    var endDateString: String {
        guard let endDate else { return "--:--" }
        return Self.timeFormatter.string(from: endDate)
    }
    
    var progress: Double {
        guard sessionDuration > 0 else { return 0 }
        return remaining / sessionDuration
    }
    
    private func startTicking() {
        systemTimer?.invalidate()
        systemTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { _ in
                self.updateRemainingTime()
            }
    }
    
    private func stopTicking() {
        systemTimer?.invalidate()
        systemTimer = nil
    }
    
    init () {
        Task {
            await notificationService.requestPermition()
        }
        remaining = sessionDuration
        if let date = UserDefaults.standard.object(forKey: DefaultsKeys.endDate),
           let endDate = date as? Date
        {
            self.endDate = endDate
            remaining = max(endDate.timeIntervalSinceNow, 0)
            if (remaining == 0) {
                UserDefaults.standard.removeObject(forKey: DefaultsKeys.timerState)
                UserDefaults.standard.removeObject(forKey: DefaultsKeys.endDate)
                return
            }
        } else {
            return
        }
        if let timerStateRawValue = UserDefaults.standard.string(forKey: DefaultsKeys.timerState),
           let timerState = TimerState(rawValue: timerStateRawValue) {
            self.timerState = timerState
        }
        if (timerState == TimerState.overtime || timerState == TimerState.running) {
            startTicking()
        }
    }
    
    func setContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func start() {
        let block = WorkBlock(
            activity: selectedActivity,
            session: nil,
            quality: selectedQuality,
            plannedDuration: sessionDuration
        )
        modelContext?.insert(block)
        currentBlock = block
        remaining = sessionDuration
        endDate = .now + sessionDuration
        userDefaults.set(endDate, forKey: DefaultsKeys.endDate)
        timerState = .running
        userDefaults.set(timerState.rawValue, forKey: DefaultsKeys.timerState)
        startTicking()
        guard let date = endDate else { return }
        notificationService.scheduleTimerNotification(at: date)
    }
    
    func pause() {
        currentBlock?.pauseCounter += 1
        remainingTimeAtPause = endDate?.timeIntervalSinceNow
        timerState = .paused
        userDefaults.set(timerState.rawValue, forKey: DefaultsKeys.timerState)
        stopTicking()
        notificationService.cancelNotification(for: .timerFinished)
    }
    
    func resume() {
        guard let remaining = remainingTimeAtPause else { return }
        endDate = Date.now + TimeInterval(remaining)
        userDefaults.set(endDate, forKey: DefaultsKeys.endDate)
        startTicking()
        timerState = .running
        userDefaults.set(timerState.rawValue, forKey: DefaultsKeys.timerState)
        guard let date = endDate else { return }
        notificationService.scheduleTimerNotification(at: date)
    }
    
    func stop() {
        finishBlock()
    }
    
    func updateRemainingTime() {
        if (timerState != .overtime) {
            guard let date = endDate else { return }
            remaining = max(date.timeIntervalSinceNow, 0)
            
            if remaining == 0 {
                stopTicking()
                Task { @MainActor in
                    try? await Task.sleep(for: .seconds(1))
                    self.finishBlock()
                }
            }
        } else {
            guard let overTimeStartDate else { return }
            overTimeDuration = Date.now.timeIntervalSince(overTimeStartDate)
        }
    }
    
    func finishBlock() {
        currentBlock?.endDate = .now
        currentBlock?.actualDuration = sessionDuration - remaining
        currentBlock?.state = .finished
        try? modelContext?.save()
        
        endDate = nil
        remainingTimeAtPause = nil
        remaining = sessionDuration
        timerState = .finished
        currentBlock = nil
        stopTicking()
        UserDefaults.standard.removeObject(forKey: DefaultsKeys.timerState)
        UserDefaults.standard.removeObject(forKey: DefaultsKeys.endDate)
        notificationService.cancelNotification(for: .timerFinished)
    }
    
    func startOvertime() {
        overTimeStartDate = Date.now
        timerState = .overtime
        startTicking()
    }
    
    func finishOvertime() {
        guard let overTimeStartDate else { return }
        overTimeDuration = Date.now.timeIntervalSince(overTimeStartDate)
        timerState = .idle
    }
}
