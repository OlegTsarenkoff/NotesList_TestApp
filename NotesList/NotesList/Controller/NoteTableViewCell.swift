//
//  NoteCell.swift
//  NotesList
//
//  Created by Oleg Tsarenkoff on 7.08.21.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var headingNoteLabel: UILabel!
    @IBOutlet weak var descriptionNoteLabel: UILabel!

    func set(note: Note) {
        self.headingNoteLabel.text = note.noteTitle
        self.descriptionNoteLabel.text = note.noteSubtitle
    }
}
