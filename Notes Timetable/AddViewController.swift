//
//  AddViewController.swift
//  Notes Timetable
//
//  Created by Sanuj Bhatia on 7/12/18.
//  Copyright © 2018 Sanuj Bhatia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

var noteOutput : String?

class AddViewController: UIViewController {
    
    var dbRef : DatabaseReference!
    var databaseHandler : DatabaseHandle?
    

    
    @IBAction func doneTest(_ sender: Any) {
        counter = counter + 1
        tableView?.reloadData()
        }
    
    
    @IBOutlet weak var textViewOutput: UITextView!
    
    var noteCreated : String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if textViewOutput.text != "" {
            noteCreated = textViewOutput.text
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
