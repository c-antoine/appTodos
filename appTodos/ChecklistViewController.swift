//
//  ViewController.swift
//  appTodos
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 Antoine. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var dataList = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let item1 = ChecklistItem(text: "Finir le cours d’iOS");
        let item2 = ChecklistItem(text: "Mettre à jour XCode", checked: true);
        dataList.append(item1)
        dataList.append(item2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Table count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    //Data access
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureText(for: cell, withItem: dataList[indexPath.row])
        configureCheckmark(for: cell, withItem: dataList[indexPath.row])
        return cell
    }
    
    //Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataList[indexPath.row].toggleChecked();
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem) {
        if (item.checked == true) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.textLabel?.text = item.text
    }

    @IBAction func addDummyTodo(_ sender: Any) {
        let item = ChecklistItem(text: "Hello");
        dataList.append(item);
        let indexPath: IndexPath = IndexPath (row: dataList.count-1, section: 0);
        tableView.insertRows(at: [indexPath], with: .automatic);
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataList.remove(at: indexPath.row);
        tableView.deleteRows(at: [indexPath], with: .automatic);
    }
}

extension ChecklistViewController : AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController){
        dismiss(animated: true);
    }
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem){
        dataList.append(item);
        let indexPath: IndexPath = IndexPath (row: dataList.count-1, section: 0);
        tableView.insertRows(at: [indexPath], with: .automatic);
        dismiss(animated: true);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
    }
}
