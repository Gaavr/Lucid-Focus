//
//  Break.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 09.03.2026.
//

import Foundation
import SwiftData

@Model
final class Break {
    var id: UUID
    var startDate: Date
    var duration: TimeInterval
    
    var session: Session?
    var afterBlockId: UUID
    
    init(session: Session?, afterBlockId: UUID) {
        self.id = UUID()
        self.startDate = .now
        self.duration = 0
        self.session = session
        self.afterBlockId = afterBlockId
    }
}

extension Break {
    static var example: Break {
        Break(session: .example, afterBlockId: UUID())
    }
}
