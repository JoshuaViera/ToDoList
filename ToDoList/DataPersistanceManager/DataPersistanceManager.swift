//
//  DataPersistanceManager.swift
//  ToDoList
//
//  Created by Joshua Viera on 1/11/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import Foundation

final class DataPersistanceManager {
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func filepathToDocumentDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
