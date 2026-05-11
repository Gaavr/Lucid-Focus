//
//  Activity.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 09.03.2026.
//

import SwiftData
import Foundation


@Model
final class Activity {
    var id: UUID
    var name: String
    var color: String
    var icon: String
    var created: Date
    var template: PomodoroTemplate
    
    init(name: String, color: String, icon: String, created: Date, template: PomodoroTemplate = PomodoroTemplate.defaultTemplate) {
        self.id = UUID()
        self.name = name
        self.color = color
        self.icon = icon
        self.created = created
        self.template = template
    }
}

extension Activity {
    static var example: Activity {
        Activity(name: "iOS Dev", color: "blue", icon: "swift", created: .now, template: PomodoroTemplate.defaultTemplate)
    }
    
    static var examples: [Activity] {
        [
            Activity(name: "iOS Dev",   color: "blue",   icon: "swift",        created: .now, template: PomodoroTemplate.defaultTemplate),
            Activity(name: "Chinese",   color: "red",    icon: "character.book.closed", created: .now, template: PomodoroTemplate.defaultTemplate),
            Activity(name: "Woodwork",  color: "brown",  icon: "hammer",       created: .now, template: PomodoroTemplate.defaultTemplate),
        ]
    }
}
