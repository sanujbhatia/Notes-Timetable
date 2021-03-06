//
//  NotesViewController.swift
//  Notes Timetable
//
//  Created by Sanuj Bhatia on 7/8/18.
//  Copyright © 2018 Sanuj Bhatia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SwiftyJSON


var counter = 0
var tableVar : UITableView?
var tableView: UITableView?
var array : [Any]?
var notesArray = [String]()

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var items: [NoteItem] = []
    var dbRef : DatabaseReference?
    var databaseHandler: DatabaseHandle?
    let currUser = Auth.auth().currentUser!
    let ref = Database.database().reference(withPath: "users")
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "addVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! notesTableViewCell
        let noteItm = items[indexPath.row]
        
        cell.noteLabel.text = noteItm.description
        
        return cell
    }
    
    
    @IBAction func unwindToNotes(_ sender: UIStoryboardSegue) {
    }

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        let user = Auth.auth().currentUser!
        let userRef = Database.database().reference().child("users").child(user.uid).child("Notes")
        
        
        userRef.queryOrdered(byChild: "completed").observe(.value, with: { (snapshot) in
            var newItems : [NoteItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let noteItem2 = NoteItem(snapshot: snapshot) {
                    newItems.append(noteItem2)
                }
            }
            
            self.items = newItems
            self.tableView.reloadData()
            
        })
 
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    
    @IBAction func unwindFromAddView (_ sender : UIStoryboardSegue){
        
        if sender.source is AddViewController {
            if let senderVC = sender.source as? AddViewController {
                
                let noteitem = NoteItem(description: senderVC.noteCreated, completed: "true")
                
                let user2 = Auth.auth().currentUser!
                let userRef2 = Database.database().reference().child("users").child(user2.uid)
                
                
                let noteitemRef = userRef2.child("Notes").child(String(counter + 1))
                noteitemRef.setValue(noteitem.toAnyObject())
                
            }
        }
        
    }

}
