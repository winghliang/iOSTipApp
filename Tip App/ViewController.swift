//
//  ViewController.swift
//  Tip App
//
//  Created by Wing H. Liang on 5/5/16.
//  Copyright © 2016 Wing H. Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var totalString = "0"
    var decimalPressed = false
    var decimalCount = 0
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var percentageSlider: UISlider!
    
    @IBOutlet weak var partySizeSlider: UISlider!
    
    @IBOutlet weak var percentage1Label: UILabel!

    @IBOutlet weak var tip1Label: UILabel!
    
    @IBOutlet weak var totalPP1Label: UILabel!
    
    @IBOutlet weak var percentage2Label: UILabel!

    @IBOutlet weak var tip2Label: UILabel!
    
    @IBOutlet weak var totalPP2Label: UILabel!
    
    @IBOutlet weak var percentage3Label: UILabel!
    
    @IBOutlet weak var tip3Label: UILabel!
    
    @IBOutlet weak var totalPP3Label: UILabel!
    
    @IBOutlet weak var partySizeLabel: UILabel!

    //update values if tip slider changes
    @IBAction func tipSliderChanged(sender: UISlider) {
        updateValues()
    }
    
    //update values if party size slider changes
    @IBAction func partySlider(sender: UISlider) {
        partySizeLabel.text = "Party Size: \(Int(partySizeSlider.value))"
        updateValues()
    }
    
    //update values if buttons pressed regarding total bill
    @IBAction func buttonPressed(sender: UIButton) {

        //if "C" button was pressed, reset values
        if sender.tag == 10 {
            totalString = "0"
            decimalPressed = false
            decimalCount = 0
        
        //if decimal was pressed for first time, concat a decimal and change decimalPressed flag to true
        //any time the decimal is pressed thereafter, don't do anything
        } else if sender.tag == 11 {
            if decimalPressed == false {
                totalString += "."
                decimalPressed = true
            } else {
                print("Decimal already pressed.  Not taking any action.")
            }
        } else {
            
            //if any of the numbers was pressed
            //check to make sure user cannot enter more digits if decimal was presssed and two more digits had been entered thereafter (e.g., so that there cannot be 3 decimal values)
            
            if decimalCount <= 2 {

                //if total is initially 0, don't concat the 0
                if totalString == "0" {
                    totalString = String(sender.tag)

                //otherwise, concat the number to the total
                } else {
                    totalString = totalString + String(sender.tag)
                }
                
                //increment the decimal count if the decimal was previously set to true
                if decimalPressed == true {
                    decimalCount += decimalCount + 1
                }
                
            }
        }
        totalLabel.text = totalString
        updateValues()
    }

    
    func updateValues() {
        
        //get value of slider & round to nearest integer
        let percentageInt = Int(round(percentageSlider.value))
        let percentageInt2 = percentageInt + 5
        let percentageInt3 = percentageInt + 10
        
        //update text to show percentages
        percentage1Label.text = "\(percentageInt)%"
        percentage2Label.text = "\(percentageInt2)%"
        percentage3Label.text = "\(percentageInt3)%"
        
        //calculate tip amount & round to two decimal places, then update tip label
        let tip1AmountUnrounded = (Double(totalString)! * Double(percentageInt)/100) / Double(Int(partySizeSlider.value))
        let tip1Amount = Double(round(tip1AmountUnrounded*100)/100)
        tip1Label.text = "\(tip1Amount)"
        
        let tip2AmountUnrounded = (Double(totalString)! * Double(percentageInt2)/100) / Double(Int(partySizeSlider.value))
        let tip2Amount = Double(round(tip2AmountUnrounded*100)/100)
        tip2Label.text = "\(tip2Amount)"
        
        let tip3AmountUnrounded = (Double(totalString)! * Double(percentageInt3)/100) / Double(Int(partySizeSlider.value))
        let tip3Amount = Double(round(tip3AmountUnrounded*100)/100)
        tip3Label.text = "\(tip3Amount)"
        
        //calculate the total per person amount
        let totalPP1Unrounded = Double(totalString)! / Double(Int(partySizeSlider.value)) + tip1Amount
        let totalPP1 = Double(round(totalPP1Unrounded*100)/100)
        totalPP1Label.text = "$\(totalPP1)"
        
        let totalPP2Unrounded = Double(totalString)! / Double(Int(partySizeSlider.value)) + tip2Amount
        let totalPP2 = Double(round(totalPP2Unrounded*100)/100)
        totalPP2Label.text = "$\(totalPP2)"
        
        let totalPP3Unrounded = Double(totalString)! / Double(Int(partySizeSlider.value)) + tip3Amount
        let totalPP3 = Double(round(totalPP3Unrounded*100)/100)
        totalPP3Label.text = "$\(totalPP3)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalLabel.text = totalString

        //set initial tip percentages and amounts
        percentage1Label.text = "\(percentageSlider.value)%"
        percentage2Label.text = "\(percentageSlider.value + 5)%"
        percentage3Label.text = "\(percentageSlider.value + 10)%"
        tip1Label.text = "0.00"
        totalPP1Label.text = "0.00"
        tip2Label.text = "0.00"
        totalPP2Label.text = "0.00"
        tip3Label.text = "0.00"
        totalPP3Label.text = "0.00"
        partySizeLabel.text = "Party Size: \(Int(partySizeSlider.value))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

