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
    
    var items: [Item]?{
        didSet{
            tableView.reloadData()
        }
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemsNav"{
        guard let indexPath = tableView.indexPathForSelectedRow, let detailVC = segue.destination as? ItemDetailVC else {
            fatalError("indexPath, detailVC nil")
        }
            let indexNum = indexPath.row
            let items = ItemModel.getItems()[indexPath.row]
            detailVC.items = items
            detailVC.index = indexNum
           
            
        } else if segue.identifier == "AddNav"{
            
        }
        
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
