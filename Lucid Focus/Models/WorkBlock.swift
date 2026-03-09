//
//  WorkBlock.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 09.03.2026.
//

import Foundation
import SwiftData

@Model
final class WorkBlock {
    var id: UUID
    var quality: TimeQuality
    var plannedDuration: TimeInterval
    var actualDuration: TimeInterval
    var overtimeDuration: TimeInterval
    var pauseCounter: Int
    var startDate: Date
    var endDate: Date?
    var state: BlockState
    
    var activity: Activity?
    var session: Session?
    
    init(activity: Activity, session: Session? = nil, quality: TimeQuality, plannedDuration: TimeInterval) {
        self.id = UUID()
        self.quality = quality
        self.plannedDuration = plannedDuration
        self.actualDuration = 0
        self.overtimeDuration = 0
        self.pauseCounter = 0
        self.startDate = .now
        self.state = .running
        self.activity = activity
        self.session = session
    }
}

extension WorkBlock {
    static var example: WorkBlock {
        WorkBlock(
            activity: .example,
            session: .example,
            quality: .deep,
            plannedDuration: 25 * 60
        )
    }
    
    static var standaloneExample: WorkBlock {
        WorkBlock(
            activity: .example,
            session: nil,
            quality: .light,
            plannedDuration: 120 * 60
        )
    }
}
