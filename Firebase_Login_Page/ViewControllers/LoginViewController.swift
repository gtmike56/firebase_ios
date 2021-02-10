//
//  LoginViewController.swift
//  Firebase_Login_Page
//
//  Created by Mikhail Udotov on 2021-02-07.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        //Validate fields
        let error = validateTheFields()
        if error != nil {
            showError(message: error!)
        } else {
            //Create cleaned versions of the data
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Singing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError(message: error!.localizedDescription)
                } else {
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
    
    func validateTheFields() -> String? {
        
        //Check all fields are filled in
        if ((emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "" || (passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "")  {
            return "Please fill in all fields"
        }
        return nil
    }
    
    func setUpElements() {
        
        //Hide the 'error' label
        errorLabel.alpha = 0
        
        //Style the elements
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleFilledButton(loginBtn)
    }

}
