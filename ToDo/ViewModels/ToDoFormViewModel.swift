//
//  ToDoFormViewModel.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

import Foundation

final class ToDoFormViewModel: ObservableObject {
    
    var id: String?
    @Published var name: String = ""
    @Published var isCompleted: Bool = false
    
    var updatingMode: Bool {
        return id != nil
    }
    
    var isDisabled: Bool {
        return name.isEmpty
    }
    
    init() {}
    
    init(_ currentToDo: ToDo) {
        self.id = currentToDo.id
        self.name = currentToDo.name
        self.isCompleted = currentToDo.isCompleted
    }
    
}
