//
//  ToDoFormView.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

import SwiftUI

struct ToDoFormView: View {
    
    @EnvironmentObject private var dataStore: DataStore
    @ObservedObject var formVM: ToDoFormViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    TextField("ToDo", text: $formVM.name)
                    Toggle("Is Completed", isOn: $formVM.isCompleted)
                }
            }
            
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
            .navigationTitle("ToDo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension ToDoFormView {
    
    private var cancelButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
    }
    
    private var updateSaveButton: some View {
        Button(action: formVM.updatingMode ? updateToDo : addToDo, label: {
            Text(formVM.updatingMode ? "Update" : "Save")
        })
            .disabled(formVM.isDisabled)
    }
    
    func addToDo() {
        let toDo = ToDo(name: formVM.name)
        dataStore.addToDo(toDo)
        
        presentationMode.wrappedValue.dismiss()
    }
    
    func updateToDo() {
        guard let id = formVM.id else { return }
        
        let toDo = ToDo(id: id, name: formVM.name, isCompleted: formVM.isCompleted)
        dataStore.updateToDo(toDo)
        
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct ToDoFormView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoFormView(formVM: ToDoFormViewModel())
            .environmentObject(DataStore())
    }
}
