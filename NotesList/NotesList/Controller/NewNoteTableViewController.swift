//
//  NewNoteTableViewController.swift
//  NotesList
//
//  Created by Oleg Tsarenkoff on 7.08.21.
//

import UIKit

class NewNoteTableViewController: UITableViewController {
    
    var note = Note(noteTitle: "", noteSubtitle: "")
    
    @IBOutlet weak var headingTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        updateUI()
        updateSaveButtonState()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateSaveButtonState() {
        let noteText = headingTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        saveButton.isEnabled = !noteText.isEmpty && (noteText.count <= 250 || descriptionText.count <= 1000)
    }
    
    private func updateUI() {
        headingTextField.text = note.noteTitle
        descriptionTextField.text = note.noteSubtitle
    }
    
    @IBAction func headingTextChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let headingTF = headingTextField.text ?? ""
        let descriptionTF = descriptionTextField.text ?? ""
        
        self.note = Note(noteTitle: headingTF, noteSubtitle: descriptionTF)
    }
}

extension NewNoteTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == headingTextField {
            descriptionTextField.becomeFirstResponder()
        }
        return true
    }
}
