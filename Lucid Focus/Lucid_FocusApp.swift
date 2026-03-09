//
//  Lucid_FocusApp.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 04.03.2026.
//

import SwiftData
import SwiftUI

@main
struct Lucid_FocusApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Activity.self, WorkBlock.self, Session.self, Break.self])
    }
}
