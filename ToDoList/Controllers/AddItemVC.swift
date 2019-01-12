//
//  AddItemVC.swift
//  ToDoList
//
//  Created by Joshua Viera on 1/11/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import UIKit

class AddItemVC: UIViewController {
    
    
    
    @IBOutlet weak var itemTitleTextView: UITextView!
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    private var itemTitlePlaceholder = "title"
    private var itemDescriptionPlaceHolder = "Description..."
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextViews()
    }
    private func setUpTextViews() {
        itemTitleTextView.delegate = self
        itemDescriptionTextView.delegate = self
        itemDescriptionTextView.text = itemDescriptionPlaceHolder
        itemTitleTextView.text = itemTitlePlaceholder
        itemTitleTextView.textColor = .lightGray
        itemDescriptionTextView.textColor = .lightGray
    }
    
    @IBAction func addItem(_ sender: Any) {
        guard let itemTitle = itemTitleTextView.text, let itemDescription = itemDescriptionTextView.text else {fatalError("title, description nil")}
        
        //timeStamp base on the current time
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate ,.withFullTime,.withInternetDateTime, .withTimeZone,.withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        
        //create an item
        let item = Item.init(title: itemTitle, description: itemDescription, createdAt: timeStamp)
        
        //save item to documents directory
        ItemModel.addItem(item: item)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension AddItemVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if itemTitleTextView.text == itemTitlePlaceholder{
            textView.text = ""
            textView.textColor = .black
        }
        if itemDescriptionTextView.text == itemDescriptionPlaceHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }

}
