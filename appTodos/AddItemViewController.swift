//
//  AddItemTableViewController.swift
//  appTodos
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 Antoine. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textOutlet: UITextField!
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    @IBAction func done() {
        dismiss(animated: true)
    }
    @IBAction func cancel() {
        dismiss(animated: true);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textOutlet.becomeFirstResponder();
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldString = textField.text!
        let newString = oldString.replacingCharacters(in: Range(range, in:oldString)!, with: string)
        self.doneOutlet.isEnabled = !newString.isEmpty
        return true
    }
    
}


