//
//  BlockState.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 09.03.2026.
//


enum TimerState: String, Codable {
    case idle
    case running
    case paused
    case overtime
    case finished
}
