//
//  NotesListTableViewController.swift
//  NotesList
//
//  Created by Oleg Tsarenkoff on 6.08.21.
//

import UIKit

class NotesListTableViewController: UITableViewController {

    var notes = [Note(noteTitle: "Заметка 1", noteSubtitle: "Описание заметки 1"),
                 Note(noteTitle: "Заметка 2", noteSubtitle: "Описание заметки 2")]
                 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        self.navigationItem.leftBarButtonItem = self.editButtonItem

    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewNoteTableViewController
        let note = sourceVC.note
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            notes[selectedIndexPath.row] = note
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: notes.count, section: 0)
            notes.append(note)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editNote" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let note = notes[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newNoteVC = navigationVC.topViewController as! NewNoteTableViewController
        newNoteVC.note = note
        newNoteVC.title = "Edit"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesTableViewCell
        let note = notes[indexPath.row]
        cell.set(note: note)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
    
}
