//
//  TimerFinishedType.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 13.03.2026.
//

import Foundation

enum TimerFinishedType {
    case workBlockFinished
    case breakBlockFinished
    case lastWorkBlockFinished
    
    var title: String {
        switch self {
        case .workBlockFinished:
            return "Working block completed"
        case .breakBlockFinished:
            return "Break completed"
        case .lastWorkBlockFinished:
            return "Session completed"
        }
    }
    
    var subTitle: String {
        switch self {
        case .workBlockFinished:
            return "Let's take a break"
        case .breakBlockFinished:
            return "Let's start new session"
        case .lastWorkBlockFinished:
            return "Finish session or start overtime"
        }
    }
    
    var primaryButtonName: String {
        switch self {
        case .workBlockFinished:
            return "Start break"
        case .breakBlockFinished:
            return "Start work block"
        case .lastWorkBlockFinished:
            return "Start overtime"
        }
    }
    var secondaryButtonName: String {
        switch self {
        case .workBlockFinished:
            return "Skip pause"
        default:
            return "Finish session"
        }
    }
}
