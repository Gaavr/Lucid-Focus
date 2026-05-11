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
    var activity: Activity?
    @Relationship(deleteRule: .cascade) var workBlocks: [WorkBlock] = []
    @Relationship(deleteRule: .cascade) var breaks: [Break] = []
    
    init(activity: Activity) {
        self.id = UUID()
        self.activity = activity
    }
}

extension Session {
    static var example: Session {
        Session(activity: .example)
    }
}
