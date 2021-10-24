//
//  ToDoError.swift
//  ToDo
//
//  Created by Павел Кононов on 24.10.2021.
//

import Foundation

enum ToDoError: Error, LocalizedError {
    
    // FileManager level
    case saveEror
    case readError
    
    // ViewModel level
    case encodingError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .saveEror:
            return NSLocalizedString("Could not save ToDos, please try again or reinstall the app.",
                                     comment: "")
        case .readError:
            return NSLocalizedString("Could not read ToDos, pleasy try reopen the app or reinstall it.",
                                     comment: "")
        case .encodingError:
            return NSLocalizedString("Could not encode the ToDos correctly, please try reopen the app or reinstall it.",
                                     comment: "")
        case .decodingError:
            return NSLocalizedString("Could not decode the ToDos correctly, please try reopen the app or reinstall it.",
                                     comment: "")
        }
    }
    
}

struct ErrorType: Identifiable {
    
    let id = UUID()
    let error: ToDoError
    
}
