//
//  ViewController.swift
//  Hydration_Show
//
//  Created by  Ho Ivan on 9/1/20.
//  Copyright © 2020  Ho Ivan. All rights reserved.
//

import UIKit
import AVFoundation

class ShowViewController: UIViewController {
    // Initialize all the UI Comonents
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var buttonS: UIButton!
    @IBOutlet weak var buttonM: UIButton!
    @IBOutlet weak var buttonL: UIButton!
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    // Initialize controller variables
    var imageNameStr = ""
    var nowWater : Int = 0
    var targetWater : Int = 0
    var nowWaterPercent : Int = 0
    var gender : String = ""
    var confirmDrinking : [Int] = []
    var audioPlayerDrink = AVAudioPlayer()
    var audioPlayerLV = AVAudioPlayer()
    var audioStop = AVAudioPlayer()
    var audioDrinkSound =  URL(fileURLWithPath: Bundle.main.path(forResource: "DrinkSound", ofType: "mp3")!)
    var audioLVSound = URL(fileURLWithPath: Bundle.main.path(forResource: "LVSound", ofType: "mp3")!)
    var audioStopSound = URL(fileURLWithPath: Bundle.main.path(forResource: "StopSound", ofType: "mp3")!)
    var userProfile = UserProfile(gender: "", age: 0, height: 0.0, weight: 0.0, activity: "")
    var defaults = UserDefaults.standard

    // Initialize viewDidLoad function
    override func viewDidLoad() {
        sliderBar.value = 250
        sliderBar.maximumValue = 1000
        sliderBar.minimumValue = 0
        userProfile = downloadData()!
        // Assign value from struct
        targetWater = userProfile.waterTarget
        nowWaterPercent = userProfile.waterDrank * 100 / targetWater
        percentLabel.text = String(nowWaterPercent) + "%"
        gender = userProfile.gender
        if gender == "Male" {
            imageNameStr = "Male_000"
        } else {
            imageNameStr = "Female_000"
        }
        super.viewDidLoad()
        updateIcon()
        print("\(userProfile.gender) : ShowViewController")
        print(audioDrinkSound)
        do {
            audioPlayerDrink = try AVAudioPlayer(contentsOf: audioDrinkSound)
            audioPlayerLV = try AVAudioPlayer(contentsOf: audioLVSound)
            audioStop = try AVAudioPlayer(contentsOf: audioStopSound)
        } catch {
            print(error)
        }
    }

    
    
    // Func to update slider value
    @IBAction func btnUpdate(_ sender: UIButton) {
        if sender.currentTitle == "S" {
            //buttonS.isSelected =
            sliderBar.value = 100
        } else if sender.currentTitle == "M" {
            sliderBar.value = 250
        } else if sender.currentTitle == "L" {
            sliderBar.value = 500
        }
        sliderValueLabel.text = String(format: "%.0f", sliderBar.value) + " ml"
    }
    
    // Func to update label next to slider when value changed
    @IBAction func sliderChange(_ sender: UISlider) {
        sliderValueLabel.text = String(format: "%.0f", sliderBar.value) + " ml"
    }
    
    // Func to update Percentage label when button (logo) was clicked
    @IBAction func confirmBtn(_ sender: UIButton) {
        userProfile.waterDrank += Int(sliderBar.value)
        nowWaterPercent = userProfile.waterDrank * 100 / targetWater
        updateIcon()
        percentLabel.text = String(nowWaterPercent) + "%"
        confirmDrinking.append(Int(sliderBar.value))
        updateData(userProfile)
        print(confirmDrinking)
    }
    
    func updateIcon() {
        
        // find out which image we should use
        var newImageStr = ""
        // Male or Female?
        if gender == "Male" {
            newImageStr = "Male_"
        } else {
            newImageStr = "Female_"
        }
        // What is the current % water fulfilled?
        switch nowWaterPercent {
            case let waterPer where waterPer >= 100:
                newImageStr = newImageStr + "100"
            case let waterPer where waterPer >= 90:
                newImageStr = newImageStr + "090"
            case let waterPer where waterPer >= 80:
                newImageStr = newImageStr + "080"
            case let waterPer where waterPer >= 70:
                newImageStr = newImageStr + "070"
            case let waterPer where waterPer >= 60:
                newImageStr = newImageStr + "060"
            case let waterPer where waterPer >= 50:
                newImageStr = newImageStr + "050"
            case let waterPer where waterPer >= 40:
                newImageStr = newImageStr + "040"
            case let waterPer where waterPer >= 30:
                newImageStr = newImageStr + "030"
            case let waterPer where waterPer >= 20:
                newImageStr = newImageStr + "020"
            case let waterPer where waterPer >= 10:
                newImageStr = newImageStr + "010"
            default:
                newImageStr = newImageStr + "000"
        }
        
        // Debug print : Check if the image is called correctly
        if newImageStr == "Male_100" || newImageStr == "Female_100" {
            audioPlayerLV.play()
        } else {
            audioPlayerDrink.play()
        }
        imageNameStr = newImageStr
        buttonConfirm.setImage(UIImage(named: newImageStr), for: .normal)
    }
    
    @IBAction func undoBtnPressed(_ sender: UIButton) {
        if confirmDrinking.last == nil {
            audioStop.play()
        } else {
            if let lastInput = confirmDrinking.last {
                userProfile.waterDrank -= lastInput
                nowWaterPercent = userProfile.waterDrank * 100 / targetWater
                updateIcon()
                percentLabel.text = String(nowWaterPercent) + "%"
                confirmDrinking.removeLast()
                print(confirmDrinking)
            }
        }
        
    }
    
    @IBAction func setProfile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            let destinationVC = segue.destination as! ProfileViewController
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
    
    // JASON - FUNCTION FOR DOWNLOADING LOCAL DATA
    func downloadData() -> UserProfile? {
        if let savedProfile = defaults.object(forKey: "UserProfile") as? Data {
            let decoder = JSONDecoder()
            if let userProfile = try? decoder.decode(UserProfile.self, from: savedProfile) {
                return userProfile
            }
        }
        return nil
    }
}



