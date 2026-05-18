//
//  ActivityFromView.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 15.05.2026.
//

import SwiftUI

struct ActivityFormView: View {
    
    private let activity: Activity?
    
    init (activity: Activity?) {
        self.activity = activity
        if let existedActivity = activity {
            self.name = existedActivity.name
            self.color = existedActivity.getColor()
            self.icon = existedActivity.icon
            self.group = existedActivity.group ?? ""
            
            self.blockTime = existedActivity.template.templateElements.first(where: { $0.templateType == .work })?.time ?? 5400
        }
    }
    
    @State private var name: String = ""
    @State private var color: Color = .gray
    @State private var icon: String = ""
    @State private var group: String = ""
    
    @State private var blockTime: TimeInterval = 5400;
    @State private var numberOfBlocks: Int = 4;
    @State private var shortBreakTime: TimeInterval = 900
    @State private var longBreakTime: TimeInterval = 2700
    @State private var numberOfBlocksForLongBreak: Int = 2;
    
    private let descriptionActivityTitle: String = "Activity info"
    private let nameOfCategoryTitle: String = "Name"
    private let colorOfCategoryTitle: String = "Color"
    private let iconOfCategoryTitle: String = "Emoji"
    private let groupOfActivitiesTitle: String = "Group"
    
    private let timeActivityTitle: String = "Time settings"
    private let blockTimeTitle: String = "Time of one block:"
    private let numberOfBlocksTilte: String = "Number of blocks:"
    private let shortBreakTimeTitle: String = "Short break time:"
    private let longBreakTimeTitle: String = "Long break time:"
    private let numberOfBlocksForLongBreakTitle: String = "Number of blocks before long break:"
    
    var body: some View {
        Form {
            Section(descriptionActivityTitle) {
                TextField(nameOfCategoryTitle, text: $name)
                TextField(iconOfCategoryTitle, text: $icon)
                ColorPicker(colorOfCategoryTitle, selection: $color)
                TextField(groupOfActivitiesTitle, text: $group)
            }
            //TODO: Сделай дизайн с горизонтальным пикером
            Section(timeActivityTitle) {
                HStack {
                    Text(blockTimeTitle)
                        .foregroundStyle(.secondary)
                    TextField("", value: minutesBinding(seconds: $blockTime), format: .number)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(numberOfBlocksTilte)
                        .foregroundStyle(.secondary)
                    TextField("", value: $numberOfBlocks, format: .number)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(shortBreakTimeTitle)
                        .foregroundStyle(.secondary)
                    TextField("", value: minutesBinding(seconds: $shortBreakTime), format: .number)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(longBreakTimeTitle)
                        .foregroundStyle(.secondary)
                    TextField("", value: minutesBinding(seconds: $longBreakTime), format: .number)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(numberOfBlocksForLongBreakTitle)
                        .foregroundStyle(.secondary)
                    TextField("", value: $numberOfBlocksForLongBreak, format: .number)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Button {
                print("Creating activity...")
            } label: {
                Text(activity == nil ? "Create" : "Save")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.primary)
            }
            Button(role: .destructive) {
                print("Creating activity canceled...")
            } label: {
                Text("Cancel")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private func minutesBinding(seconds: Binding<TimeInterval>) -> Binding<Double> {
        Binding(
                get: { seconds.wrappedValue / 60 },
                set: { seconds.wrappedValue = $0 * 60 }
            )
    }
}

#Preview {
    ActivityFormView(activity: Activity.example)
}
