//
//  MovementDetailViewController.swift
//  PR2
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class MovementDetailViewController: UIViewController {
    // BEGIN-UOC-8.2
    var movement: Movement!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var valueDateLabel: UILabel!
    
    @IBOutlet weak var accountBalanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        
        if movement != nil
        {
            descriptionLabel.text = movement.movementDescription
            
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            var fecha = df.string(from:movement.date)
            dateLabel.text = fecha
            
            df.dateFormat = "yyyy-MM-dd"
            fecha = df.string(from:movement.valueDate)
            valueDateLabel.text = fecha
            
            //Se utiliza para redondear.
            var amountDecimal = movement.amount
            var rounded = Decimal()
            NSDecimalRound(&rounded, &amountDecimal, 2, .bankers)
                      
            let amount : String = "\(rounded)"
            if movement.amount < 0 {
               amountLabel.textColor = UIColor.red
            } else {
                amountLabel.textColor = UIColor.black
            }
            amountLabel.text = amount
            
            //Para redondear el account balance.
            var accountBalanceDecimal = movement.balance
            var roundedBalance = Decimal()
            NSDecimalRound(&roundedBalance, &accountBalanceDecimal, 2, .bankers)
            
            let accountBalance = "\(roundedBalance)"
            accountBalanceLabel.text = accountBalance
            
            if movement.rejected == true {
               createRejectedLabel()
            }
            else
            {
                createRejectButton()
            }
            
        }
        
       
    }
    // END-UOC-8.2
    
    // BEGIN-UOC-9
        
    //Crea un label en tiempo de ejecucion.
    func createRejectedLabel(){
        
        let rejectedLabel = UILabel()
        rejectedLabel.text = "Rejected"
        rejectedLabel.textColor = UIColor.red
        view.addSubview(rejectedLabel)

        rejectedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rejectedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rejectedLabel.topAnchor.constraint(equalTo: accountBalanceLabel.bottomAnchor, constant: 32).isActive = true
 
    }
    
    //Crea un bot162n en tiempo de ejecucion.
    func createRejectButton()  {
        
    
         let rejectButton = UIButton(type: .system)
         rejectButton.setTitle("Reject", for: .normal)

         view.addSubview(rejectButton)
    
        //Set Target to your button only once.
        rejectButton.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)
        
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        
        rejectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rejectButton.topAnchor.constraint(equalTo: accountBalanceLabel.bottomAnchor, constant: 32).isActive = true
      
   
          
    }
    
     
    @objc func rejectAction(sender: UIButton!) {
        
        movement.rejected = true
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
         
    }
    
    // END-UOC-9
}
