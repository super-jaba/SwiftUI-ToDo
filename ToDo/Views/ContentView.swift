//
//  ContentView.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var dataStore: DataStore
    
    @State private var modalType: ModalType? = nil
    
    var body: some View {
        NavigationView {
            Group {
                if dataStore.toDos.isEmpty {
                    VStack {
                        Text("You have no ToDos added")
                            .bold()
                            .font(.title)
                        Text("Press on the '+' to add new ToDo")
                            .font(.headline)
                    }
                    .foregroundColor(.gray)
                    .padding()
                } else {
                    List {
                        ForEach(dataStore.toDos) { toDo in
                            Button(action: {
                                // Update existing ToDo
                                modalType = .update(toDo)
                            }, label: {
                                HStack {
                                    Text(toDo.name)
                                        .foregroundColor(toDo.isCompleted ? .gray : .primary)
                                        .strikethrough(toDo.isCompleted)
                                    Spacer()
                                    Image(systemName: toDo.isCompleted ? "checkmark.circle" : "circle")
                                        .foregroundColor(toDo.isCompleted ? .green : .gray)
                                        .onTapGesture {
                                            dataStore.toggleCompletion(toDo)
                                        }
                                }
                            })
                        }
                        .onDelete { indexSet in
                            dataStore.deleteToDo(at: indexSet)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .sheet(item: $modalType) { $0 }
            .alert(item: $dataStore.appError) { appError in
                Alert(title: Text("Something went wrong..."), message: Text(appError.error.localizedDescription))
            }
            
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // Add new ToDo
                        modalType = .new
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
             
            .navigationTitle("My ToDos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataStore())
    }
}
