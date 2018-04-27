//
//  ViewController.swift
//  appTodos
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 Antoine. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var dataList = Array<ChecklistItem>()
    //var list: ChecklistItem!
    var isHidden = true
    var documentURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var fileURL: URL {
        return documentURL.appendingPathComponent("appTodos").appendingPathExtension("json")
    }
    
    class var documentURL: URL {
        return FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
            )[0]
    }
    class var fileURL: URL {
        return documentURL
            .appendingPathComponent("Checklist")
            .appendingPathExtension("json")
    }
    
    override func awakeFromNib(){
        loadChecklistItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logs for data path
        print("documentURL", documentURL)
        print("fileURL", fileURL)
        
        let item1 = ChecklistItem(text: "Finir le cours d’iOS");
        let item2 = ChecklistItem(text: "Mettre à jour XCode", checked: true);
        dataList.append(item1)
        dataList.append(item2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        let item = ChecklistItem(text: "Hello");
        dataList.append(item);
        let indexPath: IndexPath = IndexPath (row: dataList.count-1, section: 0);
        tableView.insertRows(at: [indexPath], with: .automatic);
    }
    
    //Override Table count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    //Override Data access
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureText(for: cell, withItem: dataList[indexPath.row])
        configureCheckmark(for: cell, withItem: dataList[indexPath.row])
        return cell
    }
    
    //Override Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataList[indexPath.row].toggleChecked();
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    //Override editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataList.remove(at: indexPath.row);
        tableView.deleteRows(at: [indexPath], with: .automatic);
    }
    
    //Configure checkmark
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem) {
        let subCell = cell as? CheckListItemCell
        subCell?.checkLabel.isHidden = (item.checked)
    }
    
    //Configure text
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        let subCell = cell as? CheckListItemCell
        subCell?.cellLabel.text = item.text
    }
    
    //Save dataList into a Json file
    func saveCheckListItems() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do
        {
            let data = try encoder.encode(dataList)
            print(String(data: data, encoding: .utf8)!)
            try data.write(to: ChecklistViewController.fileURL)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Load dataList from a json file
    func loadChecklistItems() {
        do {
            let decoder = JSONDecoder()
            dataList = try decoder.decode(Array<ChecklistItem>.self, from:
                Data(contentsOf: ChecklistViewController.fileURL))
            tableView.reloadData()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
}

extension ChecklistViewController : ItemDetailViewControllerDelegate {
    //Cancel
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController){
        dismiss(animated: true);
    }
    
    //didFinishAddingItem
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    {
        dataList.append(item)
        tableView.insertRows(at: [IndexPath(row: dataList.count-1, section: 0)], with: .automatic)
        saveCheckListItems()
        dismiss(animated: true)
    }
    
    //didFinishEditingItem
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem itemTemp: ChecklistItem) {
        let indexItem = dataList.index(where:{ $0 === itemTemp })!
        print(dataList[indexItem].text)
        tableView.reloadRows(at: [IndexPath(row: indexItem, section: 0)], with: .automatic)
        saveCheckListItems()
        dismiss(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            let navigationViewController = segue.destination as? UINavigationController,
            let destination = navigationViewController.topViewController as? ItemDetailViewController {
            if (identifier == "addItem") {
                destination.delegate = self
            } else if identifier == "editItem",
                let cell = sender as? UITableViewCell {
                destination.delegate = self
                let indexPath = tableView.indexPath(for: cell)
                let item = dataList[indexPath!.row]
                destination.itemToEdit = item
            }
        }
    }
}

