//
//  Session.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 09.03.2026.
//

import Foundation
import SwiftData

@Model
final class Session {
    var id: UUID
    var startDate: Date
    var endDate: Date?
    var plannedDuration: TimeInterval?
    var activity: Activity?
    @Relationship(deleteRule: .cascade) var workBlocks: [WorkBlock] = []
    @Relationship(deleteRule: .cascade) var breaks: [Break] = []
    
    init(activity: Activity, plannedDuration: TimeInterval? = nil) {
        self.id = UUID()
        self.startDate = .now
        self.plannedDuration = plannedDuration
        self.activity = activity
    }
}

extension Session {
    static var example: Session {
        Session(activity: .example, plannedDuration: 90 * 60)
    }
}
