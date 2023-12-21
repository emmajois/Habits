//
//  HabitListView.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import SwiftUI

struct HabitListView: View {
    @Environment(ViewModel.self) private var viewModel
    
    let habitList: [Habit]
    
    @State private var showingHabitCreationSheet = false
    
    var body: some View {
        List {
            ForEach(habitList) { habit in
                NavigationLink {
                    HabitDetailView(habit: habit)
                } label: {
                    if habit.isCompleted {
                        Label(habit.title, systemImage: "checkmark.circle.fill")
                    } else {
                        Text(habit.title)
                    }
                }
            }
            .onDelete(perform: deleteHabits)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: openHabitCreationSheet) {
                    Label("Add Habit", systemImage: "plus")
                }
                .sheet(isPresented: $showingHabitCreationSheet, content: {
                    HabitCreationView(habit: nil)
                })
            }
        }
    }
    
    //MARK: Functions
    private func deleteHabits(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewModel.deleteHabit(viewModel.habits[index])
            }
        }
    }
    
    private func openHabitCreationSheet() {
        showingHabitCreationSheet.toggle()
    }
}

