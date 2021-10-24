//
//  DataStore.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

import Foundation

final class DataStore: ObservableObject {
    
    @Published var toDos: [ToDo] = []
    @Published var appError: ErrorType? = nil
    
    init() {
        if FileManager().documentExists(named: fileName) {
            loadToDos()
        }
    }
    
    func addToDo(_ toDo: ToDo) {
        toDos.insert(toDo, at: 0)
        saveToDos()
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: { $0.id == toDo.id }) else { return }
        toDos[index] = toDo
        saveToDos()
    }
    
    func toggleCompletion(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: { $0.id == toDo.id }) else { return }
        toDos[index].isCompleted.toggle()
        saveToDos()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveToDos()
    }
    
    func loadToDos() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    toDos = try decoder.decode([ToDo].self, from: data)
                } catch {
                    appError = ErrorType(error: .decodingError)
                }
            case .failure(let error):
                appError = ErrorType(error: error)
            }
        }
    }
    
    func saveToDos() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(toDos)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { error in
                if let error = error {
                    appError = ErrorType(error: error)
                }
            }
        } catch {
            appError = ErrorType(error: .encodingError)
        }
    }
    
}
