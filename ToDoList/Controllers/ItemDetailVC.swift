//
//  ItemDetailVC.swift
//  ToDoList
//
//  Created by Joshua Viera on 1/11/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var edit: UIBarButtonItem!
    
    var items: Item!
    var index: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        title = items.title
    }
    
    func updateUI(){
        titleTextView.text = items?.title
        descriptionTextView.text = items?.description
    }
    
    
    
    
    @IBAction func editButton(_ sender: UIBarButtonItem){
        titleTextView.becomeFirstResponder()
        descriptionTextView.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEditing))
        titleTextView.isEditable = true
        descriptionTextView.isEditable = true
        
    }
    
    @objc private func doneEditing() {
        print("Done Editing")
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate ,.withFullTime,.withInternetDateTime, .withTimeZone,.withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        if let title = titleTextView.text {
            if let description = descriptionTextView.text {
                let newItem = Item.init(title: title, description: description, createdAt: timeStamp)
                ItemModel.update(newItem: newItem, atIndex: index)
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(doneEditing))
                titleTextView.isEditable = false
                descriptionTextView.isEditable = false
                titleTextView.resignFirstResponder()
                descriptionTextView.resignFirstResponder()
            }
        }
    }
    
}
