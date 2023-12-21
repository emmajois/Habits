//
//  HabitDetailView.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import SwiftUI

struct HabitDetailView: View {
   //@Environment (ViewModel.self) private var viewModel
    
    var habit: Habit
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(habit.title)
                        .font(.title)
                        .padding()
                    if habit.isCompleted {
                        Button("", systemImage: "circle.inset.filled") {
                            toggleIsCompleted()
                        }
                        .imageScale(.large)
                    } else {
                        Button("", systemImage: "circle") {
                            toggleIsCompleted()
                        }
                        .imageScale(.large)
                    }
                }
                Text(habit.habitDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .padding(.bottom)
                Text("Last Completed: \(habit.lastCompletedDate.formatted(.dateTime.day().month().year()))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Next time to complete: \(habit.nextCompletedDate.formatted(.dateTime.day().month().year()))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(habit.categories) { category in
                            VStack {
                                Button(category.categoryName, systemImage: "xmark.circle") {
                                    deleteCategory(categoryToDelete: category)
                                }
                                .padding()
                                .background(Capsule().stroke(.blue))
                                .foregroundStyle(.blue)
                            }
                        }
                    }
                }
                VStack {
                    LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(habit.timePeriods) { times in
                            VStack {
                                Button(times.timingName, systemImage: "xmark.circle") {
                                    deleteTiming(timingToDelete: times)
                                }
                                .padding()
                                .background(Capsule().stroke(.blue))
                                .foregroundStyle(.blue)
                            }
                        }
                    }
                }

            }
            .padding()
        }
    }
    
    //MARK: Functions
    private func toggleIsCompleted() {
        habit.isCompleted.toggle()
        
        //viewModel.saveData()
    }
    
    private func deleteCategory(categoryToDelete: HabitCategory) {
        habit.categories.removeAll { category in
            category == categoryToDelete
        }
        
       // viewModel.saveData()
    }
    
    private func deleteTiming(timingToDelete: HabitTiming) {
        habit.timePeriods.removeAll { timing in
            timing == timingToDelete
        }
        
       // viewModel.saveData()
    }
}

#Preview {
    HabitDetailView(habit: Habit(
        title: "Walk",
        habitDescription: "Walk for at least 30 minutes",
        isCompleted: false,
        lastCompletedDate: Date.now,
        nextCompletedDate: Date.now + 1,
        timePeriods: [],
        categories: []
    ))
}
