//
//  Habit.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import Foundation
import SwiftData

@Model
final class Habit {
    var title: String
    var habitDescription: String
    var isCompleted: Bool
    var lastCompletedDate: Date
    var nextCompletedDate: Date
    var timePeriod: String
    
    var categories: [HabitCategory]
    
    init(title: String, habitDescription: String, isCompleted: Bool, lastCompletedDate: Date, nextCompletedDate: Date, timePeriod: String, categories: [HabitCategory]) {
        self.title = title
        self.habitDescription = habitDescription
        self.isCompleted = isCompleted
        self.lastCompletedDate = lastCompletedDate
        self.nextCompletedDate = nextCompletedDate
        self.timePeriod = timePeriod
        self.categories = categories
    }
}

@Model
final class HabitCategory {
    var categoryName: String
    
    @Relationship(inverse: \Habit.categories)
    var habits: [Habit]
    
    init(categoryName: String, habits: [Habit]) {
        self.categoryName = categoryName
        self.habits = habits
    }
}
