//
//  PomodoroTemplate.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 13.03.2026.
//

import Foundation

struct PomodoroTemplate: Codable {
    let templateElements: [TemplateElement]
}

extension PomodoroTemplate {
    static var defaultTemplate: PomodoroTemplate {
        PomodoroTemplate(
            templateElements: [TemplateElement.exapmleWork,
                               TemplateElement.exapmleShortPause,
                               TemplateElement.exapmleWork,
                               TemplateElement.exapmleLongPause,
                               TemplateElement.exapmleWork,
                               TemplateElement.exapmleShortPause,
                               TemplateElement.exapmleWork
                              ]
        )
    }
}
