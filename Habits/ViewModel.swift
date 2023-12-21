//
//  ViewModel.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import Foundation
import SwiftData

@Observable
class ViewModel {
    //MARK: Properties
    private var modelContext: ModelContext
    
    //MARK: Init
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }
    
    //MARK: Model Access
    private(set) var habits: [Habit] = []
    private(set) var categories: [HabitCategory] = []
    private(set) var timings: [HabitTiming] = []
    
    //MARK: User Intents
    func addHabit(_ habit: Habit) {
        modelContext.insert(habit)
        
        fetchData()
    }
    
    func addCategory(_ category: HabitCategory) {
        modelContext.insert(category)
        
        fetchData()
    }
    
    func addTiming (_ timing: HabitTiming) {
        modelContext.insert(timing)
        
        fetchData()
    }
    
    func saveData() {
        try? modelContext.save()
        
        fetchData()
    }
    
    func deleteHabit (_ habit: Habit) {
        modelContext.delete(habit)
        
        fetchData()
    }
    
    func deleteCategory(_ category: HabitCategory) {
        modelContext.delete(category)
        
        fetchData()
    }
    
    func deleteTiming(_ timing: HabitTiming) {
        modelContext.delete(timing)
        
        fetchData()
    }
    
    func replaceAllHabits (
        _ habits: [Habit],
        _ baseCategories: [HabitCategory],
        _ baseTimings: [HabitTiming],
        _ categoryAssociations: [(String, String)],
        _ timingAssociations: [(String, String)]
    ) throws {
        do {
            try modelContext.delete(model: Habit.self)
            try modelContext.delete(model: HabitCategory.self)
            try modelContext.delete(model: HabitTiming.self)
        } catch {
            throw error
        }
        
        var habitTable: [String : Habit] = [:]
        var categoryTable: [String: HabitCategory] = [:]
        var timingTable: [String: HabitTiming] = [:]
        
        habits.forEach { habit in
            habitTable[habit.title] = habit
            modelContext.insert(habit)
        }
        
        baseCategories.forEach { category in
            categoryTable[category.categoryName] = category
            modelContext.insert(category)
        }
        
        baseTimings.forEach { timing in
            timingTable[timing.timingName] = timing
            modelContext.insert(timing)
        }
        
        categoryAssociations.forEach { (habit, category) in
            if let habitItem = habitTable[habit], let categoryItem = categoryTable[category] {
                habitItem.categories.append(categoryItem)
            }
        }
        
        timingAssociations.forEach { (habit, timing) in
            if let habitItem = habitTable[habit], let timingItem = timingTable[timing] {
                habitItem.timePeriods.append(timingItem)
            }
        }
        
        fetchData()
    }
    
    //MARK: Private Helpers
    private func fetchData() {
        fetchHabits()
        fetchCategories()
        fetchTimings()
    }
    
    private func fetchHabits() {
        do {
            let descriptor = FetchDescriptor<Habit>(sortBy: [SortDescriptor(\.title)])
            
            habits = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load habits")
        }
    }
    
    private func fetchCategories() {
        do {
            let descriptor = FetchDescriptor<HabitCategory>(sortBy: [SortDescriptor(\.categoryName)])
            
            categories = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load habit categories")
        }
    }
    
    private func fetchTimings() {
        do {
            let descriptor = FetchDescriptor<HabitTiming>(sortBy: [SortDescriptor(\.timingName)])
            
            timings = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load habits")
        }
    }
}
