//
//  EmmasHabits.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import Foundation

let emmaSampleHabits = [
    Habit(
        title: "Go for a Walk",
        habitDescription: "Walk for at least 30 minutes",
        isCompleted: false,
        lastCompletedDate: Date.now,
        nextCompletedDate: Date.now,
        timePeriods: [],
        categories: []
    ),
    Habit(
        title: "Read Scriptures",
        habitDescription: "Read scriptures for at least 15 minutes",
        isCompleted: true, 
        lastCompletedDate: Date.now,
        nextCompletedDate: Date.now,
        timePeriods: [],
        categories: []
    )
]

let baseCategories = [
    HabitCategory(categoryName: "Spiritual"),
    HabitCategory(categoryName: "Health"),
    HabitCategory(categoryName: "Self Improvement")
]

let baseTimings = [
    HabitTiming(timingName: "Daily", timingModifier: 1),
    HabitTiming(timingName: "Weekly", timingModifier: 7),
    HabitTiming(timingName: "Monthly", timingModifier: 31)
]

let sampleAssociationCategory = [
    ("Go for a Walk", "Health"),
    ("Read Scriptures", "Spiritual")
]

let sampleAssociationTiming = [
    ("Go for a Walk", "Daily"),
    ("Read Scriptures", "Daily")
]
