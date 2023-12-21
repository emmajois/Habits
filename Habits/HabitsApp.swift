//
//  HabitsApp.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import SwiftUI
import SwiftData

@main
struct HabitsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Habit.self, HabitCategory.self, HabitTiming.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HabitView(sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
