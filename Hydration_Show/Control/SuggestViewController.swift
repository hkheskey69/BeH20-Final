//
//  ViewController.swift
//  Waterproject
//
//  Created by Tigger on 1/9/2020.
//  Copyright © 2020 Tigger. All rights reserved.
//

import UIKit

class SuggestViewController: UIViewController {
    
    var userProfile = UserProfile(gender: "", age: 0, height: 0.0, weight: 0.0, activity: "")

    var watercalculator = WaterCalculator(w: 0,act: 0)
    var litreVal = ""
    
    @IBOutlet weak var litreLabel: UILabel!
    @IBOutlet weak var customButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrievedata
        //WaterCalculator(weight,activity)
        litreLabel.text = "\(userProfile.waterTarget) ml"
        
    }

    @IBAction func customButtonPressed(_ sender: UIButton) {
        
        var textField = UITextField()

        let alert = UIAlertController(title: "Customise Daily Water Input", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in

            self.litreVal = (textField.text!)
            self.litreLabel.text = self.litreVal + " ml"
//   self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Please insert an amount in Litre"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
        
        //code to customise drinking water value
    
    @IBAction func showScreenButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toShow", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShow" {
            let destinationVC = segue.destination as! ShowViewController
            destinationVC.userProfile = userProfile
        }
    }
    
    
}
