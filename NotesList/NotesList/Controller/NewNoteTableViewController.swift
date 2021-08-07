//
//  NewNoteTableViewController.swift
//  NotesList
//
//  Created by Oleg Tsarenkoff on 7.08.21.
//

import UIKit

class NewNoteTableViewController: UITableViewController {
    
    @IBOutlet weak var headingTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func headingTextChanged(_ sender: UITextField) {
    }
    
    @IBAction func descriptionTextChanged(_ sender: UITextField) {
    }
}
