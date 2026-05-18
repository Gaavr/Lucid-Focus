//
//  Activity.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 09.03.2026.
//

import SwiftData
import Foundation
import SwiftUI


@Model
final class Activity: Hashable {
    var id: UUID
    var name: String
    var color: String
    var icon: String
    var group: String?
    var created: Date
    var template: PomodoroTemplate
    
    init(name: String, color: Color, icon: String, group: String? = nil, created: Date, template: PomodoroTemplate = PomodoroTemplate.defaultTemplate) {
        self.id = UUID()
        self.name = name
        self.color = color.toString()
        self.icon = icon
        self.group = group
        self.created = created
        self.template = template
    }
    
    //TODO: Сделать extention
    func getColor() -> Color {
        let parts = color
            .split(separator: ",")
            .compactMap(Double.init)
        + [0, 0, 0, 1]
        
        return Color(
            red: parts[0],
            green: parts[1],
            blue: parts[2],
            opacity: parts[3]
        )
    }
}

extension Activity {
    static var example: Activity {
        Activity(name: "iOS Dev", color: Color.teal, icon: "💻", created: .now, template: PomodoroTemplate.defaultTemplate)
    }
    
    static var examples: [Activity] {
        [
            Activity(name: "iOS Dev",   color: Color.blue,   icon: "💻",        created: .now, template: PomodoroTemplate.defaultTemplate),
            Activity(name: "Chinese",   color: Color.red,    icon: "🇨🇳", created: .now, template: PomodoroTemplate.defaultTemplate),
            Activity(name: "Woodwork",  color: Color.brown,  icon: "🔨",       created: .now, template: PomodoroTemplate.defaultTemplate),
        ]
    }
}
