//
//  ViewController.swift
//  Hydration_Show
//
//  Created by  Ho Ivan on 9/1/20.
//  Copyright © 2020  Ho Ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Initialize all the UI Comonents
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var buttonS: UIButton!
    @IBOutlet weak var buttonM: UIButton!
    @IBOutlet weak var buttonL: UIButton!
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    // Initialize controller variables
    var nowWater : Double = 0
    var targetWater : Double = 2000
    var nowWaterPercent : Double {
        return round(nowWater / targetWater * 100)
    }
    var gender : String = "Female"
    
    // Initialize viewDidLoad function
    override func viewDidLoad() {
        sliderBar.value = 250
        sliderBar.maximumValue = 1000
        sliderBar.minimumValue = 0
        buttonConfirm.setImage(UIImage(contentsOfFile: "Female_0"), for: .normal)
        super.viewDidLoad()
        updateIcon()
    }

    // Func to update slider value
    @IBAction func btnUpdate(_ sender: UIButton) {
        if sender.currentTitle == "S" {
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
        nowWater += Double(sliderBar.value)
        updateIcon()
        print(nowWaterPercent)
        percentLabel.text = String(Int( nowWaterPercent)) + "%"
    }
    
    func updateIcon() {
        
        // find out which image we should use
        var imageNameStr = ""
        // Male or Female?
        if gender == "Male" {
            imageNameStr = "Male_"
        } else {
            imageNameStr = "Female_"
        }
        // What is the current % water fulfilled?
        switch nowWaterPercent {
            case let waterPer where waterPer >= 100:
                imageNameStr = imageNameStr + "100"
            case let waterPer where waterPer >= 90:
                imageNameStr = imageNameStr + "90"
            case let waterPer where waterPer >= 80:
                imageNameStr = imageNameStr + "80"
            case let waterPer where waterPer >= 70:
                imageNameStr = imageNameStr + "70"
            case let waterPer where waterPer >= 60:
                imageNameStr = imageNameStr + "60"
            case let waterPer where waterPer >= 50:
                imageNameStr = imageNameStr + "50"
            case let waterPer where waterPer >= 40:
                imageNameStr = imageNameStr + "40"
            case let waterPer where waterPer >= 30:
                imageNameStr = imageNameStr + "30"
            case let waterPer where waterPer >= 20:
                imageNameStr = imageNameStr + "20"
            default:
                imageNameStr = imageNameStr + "10"
        }
        // Debug print : Check if the image is called correctly
        print(imageNameStr)
        buttonConfirm.setImage(UIImage(named: imageNameStr), for: .normal)
    }
    

}

