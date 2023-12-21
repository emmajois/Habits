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

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
                }
            }
        } detail: {
            Text("Select an item")
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
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
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
