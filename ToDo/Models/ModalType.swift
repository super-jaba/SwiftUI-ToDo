//
//  ModalType.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

// Creation and Updating forms are the same so we can use this for both of them with a bit of changes

import SwiftUI

enum ModalType: Identifiable, View {
    
    case new
    case update(ToDo)
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:
            return ToDoFormView(formVM: ToDoFormViewModel())
        case .update(let toDo):
            return ToDoFormView(formVM: ToDoFormViewModel(toDo))
        }
    }
    
}
