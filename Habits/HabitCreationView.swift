//
//  HabitCreationView.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import SwiftUI

struct HabitCreationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ViewModel.self) private var viewModel
    
    @State var title: String = ""
    @State var habitDescription: String = ""
    @State var isCompleted: Bool = false
    @State var lastCompletedDate: Date = Date.now
    @State var nextCompletedDate: Date = Date.now
    @State var timeSelected: Set<HabitTiming> = []
    @State var timePeriods: [HabitTiming] = []
    @State var categorySelected: Set<HabitCategory> = []
    @State var categories: [HabitCategory] = []
    
    let habit: Habit?
    
    init(habit: Habit?) {
        self.habit = habit
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Habit Information")) {
                    TextField("Title", text: $title)
                    TextField("Habit Description", text: $habitDescription)
                    Toggle(isOn:$isCompleted) {
                        Text("Completed today?")
                    }
                    DatePicker("Date Last Completed", selection: $lastCompletedDate, displayedComponents: .date)
                    DatePicker("Date to Complete Next", selection: $nextCompletedDate, displayedComponents: .date)
                }
                Section(header: Text("Habit Categories")) {
                    MultiSelector(
                        label: Text("Category"),
                        options: viewModel.categories,
                        optionToString: {$0.categoryName},
                        selected: $categorySelected
                    )
                }
                Section(header: Text("Habit Frequency")) {
                    MultiSelector(
                        label: Text("Frequency"),
                        options: viewModel.timings,
                        optionToString: {$0.timingName},
                        selected: $timeSelected
                    )
                }
            }
        }
        .navigationTitle("Add a New Habit")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    if let habit {
                        //do something
                    } else {
                        addHabit()
                    }
                    dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
    
    private func addHabit() {
        let newHabit = Habit(title: title, habitDescription: habitDescription, isCompleted: isCompleted, lastCompletedDate: lastCompletedDate, nextCompletedDate: nextCompletedDate, timePeriods: [], categories: [])
        
        timeSelected.forEach {timePeriod in
            timePeriods.append(timePeriod)
        }
        categorySelected.forEach { category in
            categories.append(category)
        }
        
        newHabit.timePeriods = timePeriods
        newHabit.categories = categories
        
        viewModel.addHabit(newHabit)
    }
}

