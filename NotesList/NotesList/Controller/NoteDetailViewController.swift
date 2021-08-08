//
//  NoteDetailViewController.swift
//  NotesList
//
//  Created by Oleg Tsarenkoff on 7.08.21.
//

import UIKit
import CoreData

class NoteDetailViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleNoteTextField: UITextField!
    @IBOutlet weak var descriptionNoteTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteCell: UITableViewCell!
    
    //MARK: - Public properties
    var selectedNote: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteCell.isHidden = true
        if selectedNote != nil {
            updateUI()
            deleteCell.isHidden = false
        }
        updateSaveButtonState()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Private func
    private func updateSaveButtonState() {
        let noteText = titleNoteTextField.text ?? ""
        saveButton.isEnabled = !noteText.isEmpty && noteText.count <= 250
    }
    
    private func updateUI() {
        titleNoteTextField.text = selectedNote?.noteTitle
        descriptionNoteTextField.text = selectedNote?.noteDescription
    }
    
    //MARK: - IBAction
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if selectedNote == nil {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newNote = Note(entity: entity!, insertInto: context)
            
            newNote.noteId = notes.count as NSNumber
            newNote.noteTitle = titleNoteTextField.text
            newNote.noteDescription = descriptionNoteTextField.text
            
            do {
                try context.save()
                notes.append(newNote)
                navigationController?.popViewController(animated: true)
            } catch {
                print("Context save error")
            }
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    if note == selectedNote {
                        note.noteTitle = titleNoteTextField.text
                        note.noteDescription = descriptionNoteTextField.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print("Fetch failed!")
            }
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                if note == selectedNote {
                    note.noteDeleted = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Delete Failed")
        }
    }

    @IBAction func headingTextChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
}

//MARK: - UITextFieldDelegate
extension NoteDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleNoteTextField {
            descriptionNoteTextField.becomeFirstResponder()
        }
        return true
    }
}
