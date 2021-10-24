//
//  ToDoApp.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

import SwiftUI

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
