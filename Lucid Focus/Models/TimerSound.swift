//
//  TimerSound.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 12.03.2026.
//

import Foundation

enum TimerSound: String, CaseIterable {
    case digital1
    case digital2
    case digital3
    case digital4
    case digital5
    case lofi
    case sound1
    case sound2
    case sound3
    
    var fileExtension: String {
        switch self {
        case .sound1, .sound3:
            return "m4a"
        default:
            return "mp3"
        }
    }
}
