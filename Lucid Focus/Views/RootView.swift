//
//  ContentView.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 04.03.2026.
//

import SwiftUI

struct RootView: View {
    
    @State private var selectedTab: AppTab = .timer
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(AppTab.statistics.rawValue, systemImage: AppTab.statistics.icon, value: AppTab.statistics) {
                StatView()
            }
            Tab(AppTab.timer.rawValue, systemImage: AppTab.timer.icon, value: AppTab.timer) {
                TimerView()
            }
            Tab(AppTab.whiteNoise.rawValue, systemImage: AppTab.whiteNoise.icon, value: AppTab.whiteNoise) {
                WhiteNoiseView()
            }
            Tab(AppTab.settings.rawValue, systemImage: AppTab.settings.icon, value: AppTab.settings) {
                SettingsView()
            }
        }
        .labelStyle(.iconOnly)
        .tint(.orange)
    }
    
    enum AppTab: String {
        case whiteNoise = "whiteNoise"
        case statistics = "Statistics"
        case timer      = "Timer"
        case settings   = "Settings"
        
        var icon: String {
            switch self {
            case .whiteNoise:      return "headphones.over.ear"
            case .statistics: return "chart.bar.fill"
            case .timer:      return "timer"
            case .settings:   return "gearshape"
            }
        }
    }
}

#Preview {
    RootView()
}


