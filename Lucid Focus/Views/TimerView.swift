//
//  TimerView.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 04.03.2026.
//

import SwiftUI

struct TimerView: View {
    
    @State private var vm = TimerViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Picker("Choose activity", selection: $vm.choosenActivity) {
                    ForEach(vm.activities, id: \.self) { activity in
                        Text(activity)
                    }
                }
                .pickerStyle(.menu)
                .tint(.primary)
                Spacer()
                Picker("Time quility", selection: $vm.choosenTimeQuility) {
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
                        .trim(from: 0, to: vm.progress)
                        .stroke(.primary, lineWidth: 10)
                        .rotationEffect(.degrees(-90))
                        .animation(
                            vm.timerState == .running || vm.timerState == .paused ? .linear(duration: 1) : .none,
                            value: vm.progress
                        )
                    VStack {
                        HStack {
                            VStack {
                                Text("Total time:")
                                    .font(.caption2)
                                Text(vm.sessionDuration.formattedClock())
                                    .font(.footnote)
                            }
                        }
                        .padding(10)
                        
                        Text(vm.remaining.formattedClock())
                            .font(.system(size: 65, weight: .bold))
                            .monospacedDigit()
                            .contentTransition(.numericText(countsDown: true))
                            .animation(.linear(duration: 1), value: vm.remaining)
                        HStack {
                            VStack {
                                Text("Timer end at:")
                                    .font(.caption2)
                                Text(vm.endDateString)
                                    .font(.footnote)
                            }
                        }
                        .padding(10)
                    }
                }
            }
            .padding(20)
            HStack {
                Button {
                    if ((vm.timerState == .idle) || (vm.timerState == .finished)) {
                        vm.start()
                    } else {
                        vm.stop()
                    }
                } label: {
                    Text((vm.timerState == .idle) || (vm.timerState == .finished) ? "Start session" : "Finish session")
                }
                Spacer()
                if vm.timerState == .running || vm.timerState == .paused {
                    Button {
                        if (vm.timerState == .running) {
                            vm.pause()
                        } else {
                            vm.resume()
                        }
                    } label: {
                        Text(vm.timerState == .running ? "Pause" : "Resume")
                    }
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
