//
//  ViewController.swift
//  Hydration Profile
//
//  Created by Jason So on 1/9/2020.
//  Copyright © 2020 Jason So. All rights reserved.
//
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var activityLevelZero: UIButton!
    @IBOutlet weak var activityLevelOne: UIButton!
    @IBOutlet weak var activityLevelTwo: UIButton!
    @IBOutlet weak var activityLevelThree: UIButton!
    
    
    var gender : String = ""
    var age : Int = 0
    var height : Double = 0.0
    var weight : Double = 0.0
    var activity : String = ""
    var userProfile = UserProfile(gender: "", age: 0, height: 0.0, weight: 0.0, activity: "")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserDefaultValue()
        // Do any additional setup after loading the view.
    }

    @IBAction func genderChanged(_ sender: UIButton) {
        if sender.currentTitle == "Male" {
            maleButton.isSelected = true
            femaleButton.isSelected = false
        } else {
            maleButton.isSelected = false
            femaleButton.isSelected = true
        }
        gender = sender.currentTitle!
        print(gender)
    }
    
    
    @IBAction func activityLevelChanged(_ sender: UIButton) {
        
        switch sender.currentTitle {
            case "0" :
                activityLevelZero.isSelected = true
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = false
            case "1" :
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = true
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = false
            case "2" :
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = true
                activityLevelThree.isSelected = false
            case "3" :
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = true
            default:
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = false
        }
        
        activity = sender.currentTitle!
        
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        height = Double(heightTextField.text!)!           //FORCE UNWRAP FOR NOW FIX LATER
        weight = Double(weightTextField.text!)!
        age = Int(ageTextField.text!)!
        
        userProfile = UserProfile(gender: gender, age: age, height: height, weight: weight, activity: activity)
        
        updateData(userProfile)

        self.performSegue(withIdentifier: "toSuggest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSuggest" {
            let destinationVC = segue.destination as! SuggestViewController
            destinationVC.userProfile = userProfile
        }
    }

    // JASON - FUNCTION FOR UPDATING LOCAL DATA
    func updateData(_ profile: UserProfile) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(profile) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "UserProfile")
        }
    }
    
    func showUserDefaultValue() {
        if userProfile.gender != "" {
            //Set Default Value
            if userProfile.gender == "Male" {
                maleButton.isSelected = true
                gender = "Male"
            } else {
                femaleButton.isSelected = true
                gender = "Female"
            }
        }
        ageTextField.text = String(userProfile.age)
        heightTextField.text = String(userProfile.height)
        weightTextField.text = String(userProfile.weight)
        
        switch userProfile.activity {
            case "0" :
                activityLevelZero.isSelected = true
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = false
            case "1" :
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = true
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = false
            case "2" :
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = true
                activityLevelThree.isSelected = false
            case "3" :
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = true
            default:
                activityLevelZero.isSelected = false
                activityLevelOne.isSelected = false
                activityLevelTwo.isSelected = false
                activityLevelThree.isSelected = false
        }
    }
    
}
