//
//  ItemListVC.swift
//  ToDoList
//
//  Created by Joshua Viera on 1/11/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import UIKit

class ItemListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print(DataPersistanceManager.documentsDirectory())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //NOT BEST PRACTICES
        //CUSTOM DELEGATION WOULD BE BEST USE CASE HERE....
        tableView.reloadData()
    }

}
extension ItemListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemModel.getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = ItemModel.getItems()[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.dateFormattedString
        return cell
    }
}

extension ItemListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // This will delete the cell
        let item = ItemModel.getItems()[indexPath.row]
        ItemModel.delete(item: item, atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
