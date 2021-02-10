//
//  SignUpViewController.swift
//  Firebase_Login_Page
//
//  Created by Mikhail Udotov on 2021-02-07.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var fNameTF: UITextField!
    
    @IBOutlet weak var lNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var singUpBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func validateTheFields() -> String? {
        
        //Check all fields are filled in
        if ((fNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "" || (lNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "" || (emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "" || (passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "")  {
            return "Please fill in all fields"
        }
        
        // Check the password
        let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure the password is at least 8 chars, contains special char and a number"
        }
        return nil
    }
    
    
    @IBAction func singUpTapped(_ sender: Any) {
        
        //Validate fields
        let error = validateTheFields()
        if error != nil {
            showError(message: error!)
        } else {
            //Create cleaned versions of the data
            let firstName = fNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    //There was an error
                    self.showError(message: error!.localizedDescription)
                } else {
                     //All good - store the data
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: [
                        "firstName": firstName,
                        "lastName": lastName,
                        "uid": result!.user.uid
                    ]) { err in
                        if err != nil {
                            self.showError(message: "Error saving user data")
                        }
                    }
                    
                    //Transition to the Home Screen
                    self.transitionToHome()
                }
            }
        }
        
    }
    
    //Programmaticly changing the VC 
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func showError(message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func setUpElements() {
        
        //Hide the 'error' label
        errorLabel.alpha = 0
        
        //Style the elements
        Utilities.styleTextField(fNameTF)
        Utilities.styleTextField(lNameTF)
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleFilledButton(singUpBtn)
    }

}
