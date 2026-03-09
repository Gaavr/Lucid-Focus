//
//  TimerViewModel.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 04.03.2026.
//

import Foundation

@Observable
final class TimerViewModel {
    
    var choosenTimeQuility: TimeQuality = TimeQuality.focus
    var choosenActivity: String = "iOS Dev"
    
    let activities: [String] = ["iOS Dev", "Task1", "Task2","iOS Dev3", "Task12", "Task23","iOS Dev4", "Task15", "Task26","iOS Dev7", "Task18", "Task29","iOS10 Dev", "Task112", "Task213"]
    
    private var systemTimer: Timer?
    
    //переделать чтобы отдельно formatter вызывать и обновлять это значение для view, когда таймер на паузек
    var endDateString: String {
        guard let endDate else { return "--:--" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: endDate)
    }
    
    var progress: Double {
        guard sessionDuration > 0 else { return 0 }
        return remaining / sessionDuration
    }
    
    func startTicking() {
        systemTimer?.invalidate()
        systemTimer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { _ in
                self.updateRemainingTime()
            }
    }
    
    func stopTicking() {
        systemTimer?.invalidate()
        systemTimer = nil
    }
    
    init () {
        remaining = sessionDuration
    }
    
    private(set) var sessionDuration: TimeInterval = 10
    private(set) var endDate: Date?
    private(set) var remainingTimeAtPause: Double?
    private(set) var timerState: TimerState = .idle
    private(set) var remaining : TimeInterval = 0
    
    func start() {
        //начинаем писать стату
        remaining = sessionDuration
        endDate = Date.now + sessionDuration
        timerState = .running
        startTicking()
    }
    
    func pause() {
        //повышаем счетчик пауз для сессии
        remainingTimeAtPause = endDate?.timeIntervalSinceNow
        timerState = .paused
        stopTicking()
    }
    
    func resume() {
        guard let remaining = remainingTimeAtPause else { return }
        endDate = Date.now + TimeInterval(remaining)
        startTicking()
        timerState = .running
    }
    
    func stop() {
        endDate = nil
        remainingTimeAtPause = 0
        remaining = sessionDuration
        timerState = .idle
        stopTicking()
    }
    
    func updateRemainingTime() {
        guard let date = endDate else { return }
        remaining = max(date.timeIntervalSinceNow, 0)
        
        if remaining == 0 {
            stopTicking()
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(1))
                timerState = .finished
            }
        }
    }
}

enum TimeQuality: String, CaseIterable{
    case focus = "Focus"
    case light = "Light"
}

enum TimerState {
    case idle
    case running
    case paused
    case finished
}
