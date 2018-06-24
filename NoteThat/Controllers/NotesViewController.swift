//
//  ViewController.swift
//  NoteThat
//
//  Created by Dylan Williamson on 6/23/18.
//  Copyright © 2018 Dylan Williamson. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController {
    
    var noteArray = [Note]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a resuable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesItemCell", for: indexPath)
        
        // Set text property to note title
        cell.textLabel?.text = noteArray[indexPath.row].title
        
        return cell
    }
    
    //MARK: - Tablewview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveNotes() {
        do {
            // Attempts to save whats in the context
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadNotes() {
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        do {
            noteArray = try context.fetch(request)
        } catch {
            print("error loading notes \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Notes
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a Note", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != "" {
                
                let newNote = Note(context: self.context)
                newNote.title = textField.text
            }
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get file path to sqlite database
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

