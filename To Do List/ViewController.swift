//
//  ViewController.swift
//  To Do List
//
//  Created by Ben Wong on 2016-09-24.
//  Copyright © 2016 Ben Wong. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var searchActive : Bool = false
    
    var notes : [Note] = []
    var filteredNotes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
//        tableView.backgroundColor = UIColor.cyan
        
        tableView.delegate = self
        searchBar.delegate = self
        
        filteredNotes = notes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotes()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return filteredNotes.count
        }
        
        return notes.count
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        print("searchBarTextDidEndEditing")
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        searchBar.text?.removeAll()
        print("searchBarCancelButtonClicked")
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        print("searchBarSearchButtonClicked")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchBar.text)
        print(searchText)
        
        if searchBar.text == nil || searchBar.text == "" {
            searchActive = false
            self.tableView.reloadData()
        } else {
            searchActive = true
            
            let lower = searchBar.text?.lowercased()
            
            filteredNotes = notes.filter({$0.text?.lowercased().range(of: lower!) != nil})
            
            print(filteredNotes)
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        var note : Note? = nil
        
        if searchActive {
            note = filteredNotes[indexPath.row]
        } else {
            note = notes[indexPath.row]
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        cell.noteText.text = note?.text
        cell.dateText.text =  dateFormatter.string(from: (note?.date)! as Date)
        return cell
    }
    
    func getNotes(){
        notes.removeAll()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            notes = try context.fetch(Note.fetchRequest()) as! [Note]
            notes = notes.reversed()
            print(notes)
            
        } catch {
            print("Error fetching from Core Data")
        }
        tableView.reloadData()
    }
    
    
    @IBAction func composeTapped(_ sender: AnyObject) {
        performSegue(withIdentifier: "newNoteSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailNoteSegue" {
            let nextVC = segue.destination as! DetailNoteViewController
            nextVC.previousNote = sender as! Note
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(note)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            getNotes()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        print("View controller \(note.text!)")
        performSegue(withIdentifier: "detailNoteSegue", sender: note)
    }
}

