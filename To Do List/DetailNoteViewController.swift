//
//  DetailNoteViewController.swift
//  To Do List
//
//  Created by Ben Wong on 2016-09-24.
//  Copyright © 2016 Ben Wong. All rights reserved.
//

import UIKit
import CoreData

class DetailNoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    var previousVC = ViewController()
    
    var previousNote :Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(previousNote?.text!)
        
        textView.delegate = self
        
        textView.text = previousNote?.text
        
        if previousNote != nil {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(previousNote!)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newNote = Note(context: context)
        
        newNote.text = textView.text
        newNote.date = NSDate()
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
