//
//  MovementsListViewController.swift
//  PR2
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class MovementsListViewController: UITableViewController {
    // BEGIN-UOC-3
    var movements = [Movement]()
    var movementsFilter = [Movement]()
    var movementToPass = Movement.init()
    
    //@IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        movements = Services.getMovements()
        movementsFilter = movements
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 75
    }
    // END-UOC-3
    

    
    
    // BEGIN-UOC-5
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //Se quema porque sabemos que solo es una seccion
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        //Aqui se debe poner la cantidad de elementos que se van a mostrar en total, es decir lo que tiene el contenedor.
        return movementsFilter.count
                
    }

    override func tableView(_ tableView	: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        				            
          
        let totalRow = tableView.numberOfRows(inSection: 0)//:indexPath.section];//first get total rows in that section by current indexPath.
       
        
        //Pregunta si ya es el ultimo registro de la seccion.
        //en caso de que lo sea pone pone el label para el ultimo movimiento.
        if indexPath.row != totalRow - 1 {
             
                
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovementCell", for: indexPath) as! MovementCell
            
                               
            let movement = movementsFilter[indexPath.row]
                            
            //Se utiliza para redondear.
            var amountDecimal = movement.amount
            var roundedAmount = Decimal()
            NSDecimalRound(&roundedAmount, &amountDecimal, 2, .bankers)
            let amount : String = "\(roundedAmount)"
                                    
            if movement.amount < 0 {
               cell.amountLabel.textColor = UIColor.red
            } else {
                cell.amountLabel.textColor = UIColor.black
            }
         
            cell.amountLabel.text = amount
             
            cell.descriptionLabel?.text = movement.movementDescription
         
            //Realiza el formato de la fecha.
            let df = DateFormatter()
                 df.dateFormat = "yyyy-MM-dd"
            let fecha = df.string(from:movement.date)
                 
            cell.dateLabel.text = fecha
            
            if movement.rejected {
                cell.backgroundColor = UIColor.systemOrange
            } else {
                cell.backgroundColor = UIColor.white
            }
                
            //Devuelve la celda que se va a pintar.
            return cell
            
         }
         else{
                             
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastMovementCell", for: indexPath)
                
            return cell
                                                   
        }

    }
        
    // END-UOC-5
    
    
    
    // BEGIN-UOC-7
    //Cuando se presione una opcion para filtrar se disppara este evento
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
             
        /* De acuerdo a la opcion que eliga, se filtra la tabla con nuevos valoers
         y se envia a recargar.
         **/
      switch sender.selectedSegmentIndex {
        case 0:
             movementsFilter = movements
        case 1:
             movementsFilter = movements.filter { $0.category == "Transfers"}
        case 2:
            movementsFilter = movements.filter { $0.category == "Credit cards"}
        case 3:
            movementsFilter = movements.filter { $0.category == "Direct debits"}
        default:
            movementsFilter = movements
        }
        
       //Una vez que tiene los valores filtrados vuelve a cargar la tabla
       tableView.reloadData()
    }
        
    // END-UOC-7
    
    // BEGIN-UOC-8.1

    //Este evento se dispara cuando se hace click sobre alguna celda.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
      // Obtiene la celda clicleada.
      let indexPath = tableView.indexPathForSelectedRow
      // Obtiene el indice
      let index = indexPath?.row
      // Define la variable del nuevo controller
      let detailViewController = segue.destination as! MovementDetailViewController
      // Toma la clase a enviar.
      movementToPass = movementsFilter[index!]
      detailViewController.movement = movementToPass
  }

    
    // END-UOC-8.1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
              
        tableView.reloadData()
    }
}
