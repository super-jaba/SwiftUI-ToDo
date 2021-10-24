//
//  ToDo.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

import Foundation

struct ToDo: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var name: String
    var isCompleted: Bool = false
    
    static var sampleData: [ToDo] {
        [
            ToDo(name: "Get groceries"),
            ToDo(name: "Make Dr. Appointment", isCompleted: true)
        ]
    }
}
