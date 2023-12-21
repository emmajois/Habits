//
//  ContentView.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import SwiftUI
import SwiftData

struct HabitView: View {
    @State private var viewModel: ViewModel
    @State private var hasError = false
    @State private var errorMessage = ""
    
    //MARK: Init
    init(_ modelContext: ModelContext) {
        _viewModel = State(initialValue: ViewModel(modelContext))
    }

    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("Habit Lists")) {
                    NavigationLink {
                        HabitListView(habitList: viewModel.habits)
                    } label: {
                        Text("Browse All")
                    }
                }
                Section(header: Text("By Category")) {
                    ForEach(viewModel.categories) { category in
                        NavigationLink {
                            if category.habits == [] {
                                Text("No habits under \(category.categoryName)")
                            } else {
                                HabitListView(habitList: viewModel.habits.filter{$0.categories.contains(where: {$0.categoryName == category.categoryName})})
                            }
                        } label: {
                            Text(category.categoryName)
                        }
                    }
                }
                Section(header: Text("By Frequency")) {
                    ForEach(viewModel.timings) { timing in
                        NavigationLink {
                            if timing.habits == [] {
                                Text("No \(timing.timingName) Habits")
                            } else {
                                HabitListView(habitList: viewModel.habits.filter{$0.timePeriods.contains(where: {$0.timingName == timing.timingName})})
                            }
                        } label: {
                            Text(timing.timingName)
                        }
                    }
                }
            }
        } content: {
            HabitListView(habitList: viewModel.habits)
        } detail: {
            Text("Select a habit")
        }
        .alert(isPresented: $hasError) {
            Alert(
                title: Text("Unable to Reset Database"),
                message: Text(errorMessage)
            )
        }
        .task {
            if viewModel.habits.isEmpty {
                withAnimation {
                    do {
                        try viewModel.replaceAllHabits(emmaSampleHabits, baseCategories, baseTimings, sampleAssociationCategory, sampleAssociationTiming)
                    } catch {
                        errorMessage = error.localizedDescription
                        hasError = true
                    }
                }
            }
        }
        .environment(viewModel)
    }
}

#Preview {
    let container = { () -> ModelContainer in
        do {
            return try ModelContainer(
                for: Habit.self, HabitCategory.self, HabitTiming.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
        } catch {
            fatalError("Failed to create ModelContainer for habits")
        }
    } ()
    return HabitView(container.mainContext)
        .modelContainer(container)
}
