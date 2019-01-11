//
//  ItemModel.swift
//  ToDoList
//
//  Created by Joshua Viera on 1/11/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import Foundation

final class ItemModel {
    
    private static let filename = "ToDoList.plist"
    private static var items = [Item]()

    static func getItems() -> [Item] {
        // FileManager
        let path = DataPersistanceManager.filepathToDocumentDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    items = try PropertyListDecoder().decode([Item].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return items
    }
    
    static func addItem(item: Item) {
        //append tot the array of items
        items.append(item)
        save()
    }
    
    static func save() {
        //path
        let path = DataPersistanceManager.filepathToDocumentDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoder error: \(error)")
        }
    }
    
    static func delete(item: Item, atIndex index: Int) {
        items.remove(at: index)
        save()
    }
}
