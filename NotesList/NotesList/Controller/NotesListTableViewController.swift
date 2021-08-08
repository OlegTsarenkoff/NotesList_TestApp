//
//  NotesListTableViewController.swift
//  NotesList
//
//  Created by Oleg Tsarenkoff on 6.08.21.
//

import UIKit
import CoreData

var notes = [Note]()

class NotesListTableViewController: UITableViewController {
    
    //MARK: - Public properties
    var firstLoad = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notes"
        fetchData()
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func noDeletedNotes() -> [Note] {
        var noDeleteNotes = [Note]()
        for note in notes {
            if note.noteDeleted == nil {
                noDeleteNotes.append(note)
            }
        }
        return noDeleteNotes
    }
    
    func fetchData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                notes.append(note)
            }
        } catch {
            print("Fetch failed!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editNote" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let noteDetailVC = segue.destination as! NoteDetailViewController
        let selectedNote = noDeletedNotes()[indexPath.row]
        noteDetailVC.title = "Edit note"
        noteDetailVC.selectedNote = selectedNote
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noDeletedNotes().count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
        let thisNote: Note!
        thisNote = noDeletedNotes()[indexPath.row]
        noteCell.titleNoteLabel.text = thisNote.noteTitle
        noteCell.descriptionNoteLabel.text = thisNote.noteDescription
        return noteCell
    }
    
    // MARK: - Хотел реализовать данным способом, но не успел по времени. :(
    // Штатная возможность перемещать элементы и удалять свайпом или через редактирование
    
    /*
        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
    
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                do {
                    let results: NSArray = try context.fetch(request) as NSArray
                    for result in results {
                        let note = result as! Note
                        if note == notes[indexPath.row] {
                            context.delete(note)
                            try context.save()
                            tableView.reloadData()
                        }
                    }
                } catch {
                    print("deleted Failed")
                }
            }
        }
    
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let moveNote = notes.remove(at: sourceIndexPath.row)
    
            notes.insert(moveNote, at: destinationIndexPath.row)
            tableView.reloadData()
        }
    
    */
}
