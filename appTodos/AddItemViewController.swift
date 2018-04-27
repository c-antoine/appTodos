//
//  AddItemTableViewController.swift
//  appTodos
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 Antoine. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate: AddItemViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    @IBOutlet weak var textOutlet: UITextField!
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    
    @IBAction func done() {
        if( itemToEdit == nil ){
            //Ajout
            delegate?.addItemViewController(self, didFinishAddingItem: ChecklistItem(text: textOutlet.text!))
        }else{
            //Edition
            delegate?.addItemViewController(self, didFinishEditingItem: itemToEdit!)
        }
                
        dismiss(animated: true)
    }
    @IBAction func cancel() {
//        dismiss(animated: true);
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            textOutlet.text = item.text
            
        }
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

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}

