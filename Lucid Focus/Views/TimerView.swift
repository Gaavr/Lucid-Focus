//
//  TimerView.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 04.03.2026.
//

import SwiftUI

struct TimerView: View {
    
    @State private var choosenActivity: String = "iOS Dev"
    @State private var choosenTimeQuility: TimeQuality = TimeQuality.focus
    
    @State private var sessionDurationInSeconds: Int = 5
    @State private var endDate: Date?
    @State private var remainingTimeAfterPause: Int = 0
    
    enum TimerState {
        case idle
        case running
        case paused
        case finished
    }
    
    let activities: [String] = ["iOS Dev", "Task1", "Task2","iOS Dev3", "Task12", "Task23","iOS Dev4", "Task15", "Task26","iOS Dev7", "Task18", "Task29","iOS10 Dev", "Task112", "Task213"]
    
    enum TimeQuality: String, CaseIterable{
        case focus = "Focus"
        case light = "Light"
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Picker("Time quility", selection: $choosenTimeQuility) {
                    ForEach(TimeQuality.allCases, id: \.self) { timeQuality in
                        Text(timeQuality.rawValue)
                    }
                }
                .pickerStyle(.palette)
                .fixedSize()
                .padding(.horizontal, 20)
                
            }
            HStack {
                ZStack {
                    Circle()
                        .stroke(.gray, lineWidth: 10)
                    
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(.primary, lineWidth: 10)
                        .rotationEffect(.degrees(-90))
                    VStack {
                        Text("1 h 30 m")
                            .font(.footnote)
                            .padding(10)
                        Text("25:55")
                            .font(.system(size: 95, weight: .bold))
                            .monospacedDigit()
                        HStack {
                            Picker("Choose activity", selection: $choosenActivity) {
                                ForEach(activities, id: \.self) { activity in
                                    Text(activity)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.primary)
                        }
                    }
                   
                    
                }
            }
            .padding(20)
            HStack {
                Button {
                    
                } label: {
                    Text("Start")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Pause")
                }
            }
            .font(.system(.headline))
            .padding(.horizontal, 30)
            Spacer()
        }
        .tint(.primary)
    }
}

#Preview {
    TimerView()
}
