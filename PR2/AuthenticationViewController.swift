//
//  AuthenticationViewController.swift
//  PR2
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourthField: UITextField!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var fourthLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // We get the string that would result of accepting the change of characters
        let currentString = textField.text ?? ""
        guard let changeRange = Range(range, in: string) else {
            return false
        }
        
        let resultingString = currentString.replacingCharacters(in: changeRange, with: string)
        
        // Then we check the length
        let resultingLength = resultingString.count
        
        if resultingLength <= 1 {
            // And finally check that the user is only entering numeric characters
            let numericSet = CharacterSet.decimalDigits
            let stringSet = CharacterSet(charactersIn: string)
            let onlyNumeric = numericSet.isSuperset(of: stringSet)
            
            if onlyNumeric {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        doAuthentication()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func doAuthentication() {
        var validCode: Bool
       
        if let firstCode = firstField.text, let secondCode = secondField.text, let thirdCode = thirdField.text, let fourthCode = fourthField.text {
            let fullCode = firstCode + secondCode + thirdCode + fourthCode
            print(fullCode)
            validCode = Services.validate(code: fullCode)
        } else {
            validCode = false
        }
        
        if validCode {
            // BEGIN-UOC-2
            
           //Primer paso...
            UIView.animate(withDuration: 0.5, animations: {
                self.firstField.alpha = 0
                self.secondField.alpha = 0
                self.thirdField.alpha = 0
                self.fourthField.alpha = 0
                
                self.firstLabel.alpha = 0
                self.secondLabel.alpha = 0
                self.thirdLabel.alpha = 0
                self.fourthLabel.alpha = 0
                 
                //Fin de segundo paso....
                 }, completion: { finished in
                     //Si hace el primer paso bien sigue con el segundo paso.
                     //Inicio segundo paso
                    UIView.animate(withDuration: 1, animations: {
                       //print("Va a ingresar al otro view")
                       self.view.addSubview(self.nextButton)
                       self.nextButton.translatesAutoresizingMaskIntoConstraints = false

                       let horizontalConstraintNextButton = NSLayoutConstraint(item: self.nextButton, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute:NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 100)
                       
                       let horizontalConstraintBackButton = NSLayoutConstraint(item: self.backButton, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute:NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -50)
                           
                       let topConstraintTitleLabel = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute:NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -50)
                       
                       NSLayoutConstraint.activate([horizontalConstraintNextButton])
                       NSLayoutConstraint.activate([horizontalConstraintBackButton])
                       NSLayoutConstraint.activate([topConstraintTitleLabel])

                       self.view.layoutIfNeeded()
                           
                       }, completion: { finished in
                            self.performSegue (withIdentifier: "SegueToMainNavigation", sender: self)
                       })
                     //Fin de segundo paso
                 })
            
            
            // END-UOC-2
        } else {
            let errorMessage = "Sorry, the entered code is not valid"
            let errorTitle = "We could not autenticate you"
            Utils.show (Message: errorMessage, WithTitle: errorTitle, InViewController: self)
        }
    }
    


    // BEGIN-UOC-1
    
    override func viewDidAppear(_ animated: Bool) {
        firstField.becomeFirstResponder()
    }
    
    @IBAction func firstFieldEditingChanged(_ sender: UITextField) {
        secondField.becomeFirstResponder()
    }
    
    @IBAction func secondFieldEditingChanged(_ sender: UITextField) {
        thirdField.becomeFirstResponder()
    }
    
    @IBAction func thirdFieldEditingChanged(_ sender: UITextField) {
        fourthField.becomeFirstResponder()
    }
    
    @IBAction func fourFieldChanged(_ sender: UITextField) {
        doAuthentication()
    }
    
    
    // END-UOC-1
}
