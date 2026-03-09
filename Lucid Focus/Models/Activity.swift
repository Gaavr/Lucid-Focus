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
    
    init(name: String, color: String, icon: String, created: Date) {
        self.id = UUID()
        self.name = name
        self.color = color
        self.icon = icon
        self.created = created
    }
}

extension Activity {
    static var example: Activity {
        Activity(name: "iOS Dev", color: "blue", icon: "swift", created: .now)
    }
    
    static var examples: [Activity] {
        [
            Activity(name: "iOS Dev",   color: "blue",   icon: "swift",        created: .now),
            Activity(name: "Chinese",   color: "red",    icon: "character.book.closed", created: .now),
            Activity(name: "Woodwork",  color: "brown",  icon: "hammer",       created: .now),
        ]
    }
}
