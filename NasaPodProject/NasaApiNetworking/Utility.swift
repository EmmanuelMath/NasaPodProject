//
//  Utility.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 15/01/2025.
//
import Foundation

func getTodaysDate() -> String {
    let today = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: today)
}


func getStartDate() -> String {
    let today = getTodaysDate()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    

    guard let todayDateObj = dateFormatter.date(from: today) else {
        print("Error: Invalid endDateString format")
        return ""
    }
    guard let startDateObj = Calendar.current.date(byAdding: .day, value: -30, to: todayDateObj) else {
        print("Error: Could not calculate startDate")
        return ""
    }
    
    let startDateString =  String(dateFormatter.string(from: startDateObj).prefix(11))
    
    return startDateString
}
