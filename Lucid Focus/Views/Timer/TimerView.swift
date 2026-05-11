//
//  TimerView.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 04.03.2026.
//

import SwiftUI

struct TimerView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var vm = TimerViewModel()
    @State private var isShowingDialog = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Picker("Choose activity", selection: $vm.selectedActivity) {
                        ForEach(vm.activities, id: \.id) { activity in
                            Text(activity.name)
                                .tag(activity)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.primary)
                    Spacer()
                    Picker("Time quility", selection: $vm.selectedQuality) {
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
                            let time = (vm.timerState == .overtime) ? vm.overTimeDuration.formattedClock() : vm.remaining.formattedClock()
                            Text(time)
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
                            if (vm.timerState != .overtime) {
                                vm.stop()
                            } else {
                                vm.finishOvertime()
                            }
                            
                        }
                    } label: {
                        Text((vm.timerState == .idle) || (vm.timerState == .finished) ? "Start block" : "Finish block")
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
            .onChange(of: vm.timerState) {
                isShowingDialog = (vm.timerState == .finished)
            }
            .tint(.primary)
            .onAppear {
                vm.setContext(modelContext)
            }
            if isShowingDialog {
                TimerFinishedView(
                    onPrimary: {
                        isShowingDialog = false
                        vm.stop()
                    },
                    onSecondary: {
                        isShowingDialog = false
                        vm.startOvertime()
                    },
                    sound: vm.sound
                )
            }
        }
        
    }
}

#Preview {
    TimerView()
}
