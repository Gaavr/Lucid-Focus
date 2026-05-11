//
//  TemplateElement.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 13.03.2026.
//

import Foundation

struct TemplateElement: Codable {
    let id: UUID
    let templateType: TemplateElementType
    let time: TimeInterval
}

extension TemplateElement {
    static var exapmleWork: TemplateElement {
        TemplateElement(
            id: UUID(),
            templateType: TemplateElementType.work,
            time: 5400
        )
    }
    static var exapmleShortPause: TemplateElement {
        TemplateElement(
            id: UUID(),
            templateType: TemplateElementType.pause,
            time: 900
        )
    }
    static var exapmleLongPause: TemplateElement {
        TemplateElement(
            id: UUID(),
            templateType: TemplateElementType.pause,
            time: 2700
        )
    }
}
