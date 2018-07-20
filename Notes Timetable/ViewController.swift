//
//  ViewController.swift
//  Notes Timetable
//
//  Created by Sanuj Bhatia on 7/8/18.
//  Copyright © 2018 Sanuj Bhatia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var emailSignUp : String?
var passwordSignUp : String?
var emailSignIn : String?
var passwordSignIn : String?



class ViewController: UIViewController {
    
    @IBAction func logout(_ sender: UIStoryboardSegue) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "notesVC")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    var databaseRef : DatabaseReference!
    
    
    @IBAction func anony(_ sender: Any) {
        
        Auth.auth().signInAnonymously { (user, error) in
            if user != nil {
                // Sign Up Successful
                self.databaseRef = Database.database().reference()
                self.databaseRef.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let snapshot = snapshot.value as? NSDictionary
                    if (snapshot) == nil {
                        self.databaseRef.child("users").child(user!.uid).child("Notes")
                    }
                })
            }
            else {
                if let myError = error?.localizedDescription
                {
                    print(myError)
                }
                else {
                    print("Error")
                }
            }
        }
        
    }
    
    // Email Sign Up
    
    @IBAction func signUp (_ sender : UIButton){
        
        let alertSU = UIAlertController(title: "Enter Your Email and Password", message: "", preferredStyle: .alert)
        
        let submitButton = UIAlertAction(title: "Sign Up!", style: .default) { (action) in
            let emailField = alertSU.textFields![0]
            let passwordField = alertSU.textFields![1]
            emailSignUp = emailField.text!
            passwordSignUp = passwordField.text!
            print(emailField.text!)
            print(passwordField.text!)
            
            if emailSignUp != "" && passwordSignUp != "" {
                Auth.auth().createUser(withEmail: emailSignUp!, password: passwordSignUp!, completion: { (user, error) in
                    if user != nil {
                     // Sign Up Successful
                        self.databaseRef = Database.database().reference()
                        self.databaseRef.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                            
                            let snapshot = snapshot.value as? NSDictionary
                            if (snapshot) == nil {
                                self.databaseRef.child("users").child(user!.uid).child("Notes")
                            }
                        })
                    }
                    else {
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                        }
                        else {
                            print("Error")
                        }
                    }
                })
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
        }
        
        // Email
        
        alertSU.addTextField { (textField : UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Enter your email here"
            textField.clearButtonMode = .whileEditing
        }
        
        // Password
        
        alertSU.addTextField { (textField : UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.placeholder = "Password : Minimum 6 characters"
            textField.clearButtonMode = .whileEditing
        }
        
        alertSU.addAction(cancelButton)
        alertSU.addAction(submitButton)
        present(alertSU, animated: true, completion: nil)
        
    }
    
    
    // Email Sign In
    
    @IBAction func signIn (_ sender : UIButton) {
        
        let alertSU = UIAlertController(title: "Enter Your Email and Password", message: "", preferredStyle: .alert)
        
        let submitButton = UIAlertAction(title: "Sign In!", style: .default) { (action) in
            let emailField = alertSU.textFields![0]
            let passwordField = alertSU.textFields![1]
            emailSignIn = emailField.text!
            passwordSignIn = passwordField.text!
            print(emailField.text!)
            print(passwordField.text!)
            
            Auth.auth().signIn(withEmail: emailSignIn!, password: passwordSignIn!, completion: { (user, error) in
                if user != nil {
                    // Sign Up Successful
                    self.databaseRef = Database.database().reference()
                    self.databaseRef.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let snapshot = snapshot.value as? NSDictionary
                        if (snapshot) == nil {
                            self.databaseRef.child("users").child(user!.uid).child("Notes")
                        }
                    })
                }
                else {
                    if let myError = error?.localizedDescription {
                        print(myError)
                    }
                    else {
                        print("Error")
                    }
                }
            })
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
        }
        
        // Email
        
        alertSU.addTextField { (textField : UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Enter your email here"
            textField.clearButtonMode = .whileEditing
        }
        
        // Password
        
        alertSU.addTextField { (textField : UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.placeholder = "Enter your password here"
            textField.clearButtonMode = .whileEditing
        }
        
        
        alertSU.addAction(cancelButton)
        alertSU.addAction(submitButton)
        present(alertSU, animated: true, completion: nil)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.databaseRef = Database.database().reference()
        let currentUser = Auth.auth().currentUser?.uid
        print(currentUser!)
    }
    
}


