//
//  TimerFinishedView.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 11.03.2026.
//

import SwiftUI

struct TimerFinishedView: View {
    
    let onStop: () -> Void
    let onOvertime: () -> Void
    let sound: TimerSound
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Focus complete")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                
                Text("Do you want to stop or continue in overtime?")
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 12) {
                    Button {
                        onOvertime()
                    } label: {
                        Text("Start overtime")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    
                    Button {
                        onStop()
                    } label: {
                        Text("Stop")
                            .font(.system(size: 17, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    }
                    .buttonStyle(.bordered)
                    .tint(.black)
                }
            }
            .padding(24)
            .frame(maxWidth: 320)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: .black.opacity(0.12), radius: 20, y: 8)
            .padding(.horizontal, 24)
        }
        .onAppear {
            SoundService.instance.play(sound)
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGray6)
            .ignoresSafeArea()
        
        TimerFinishedView(
            onStop: { print("Stop tapped") },
            onOvertime: { print("Overtime tapped") },
            sound: TimerSound.lofi
        )
    }
}
