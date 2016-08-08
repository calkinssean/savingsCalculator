//
//  ViewController.swift
//  Calculator
//
//  Created by Sean Calkins on 8/3/16.
//  Copyright © 2016 Sean Calkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var nineButton: UIButton!
    @IBOutlet var eightButton: UIButton!
    @IBOutlet var sevenButton: UIButton!
    @IBOutlet var sixButton: UIButton!
    @IBOutlet var fiveButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var oneButton: UIButton!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var decimalButton: UIButton!
    @IBOutlet var zeroButton: UIButton!
    
    @IBOutlet var yearsToSaveLabel: UILabel!
    @IBOutlet var annualInterestLabel: UILabel!
    @IBOutlet var interestEarnedLabel: UILabel!
    @IBOutlet var amountSavedLabel: UILabel!
    
    @IBOutlet var initialAmountButton: UIButton!
    @IBOutlet var monthlyDepositButton: UIButton!
    
    @IBOutlet var initialAmountLabel: UILabel!
    @IBOutlet var monthlyDepositLabel: UILabel!
    
    @IBOutlet var pickerView: UIPickerView!
    
    var pickerData = [Int]()
    var decimalPercentages = [Int]()
    
    var labelToChange = "Initial Amount"
    
    var initialAmount: Double = 0
    var monthlyDeposit: Double = 0
    var years: Double = 0
    var interestPercentage: Double = 0
    var decimalInterestPerentage: Double = 0
    
    let formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.minimumIntegerDigits = 2
        
        self.initialAmountButton.backgroundColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.00)
        
        self.setUpPickerViewComponents()
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 3
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 2 {
            
            return decimalPercentages.count
            
        }
        
        return pickerData.count
        
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if component == 0 || component == 2 {
            
            return (self.view.frame.size.width * 0.3733)
            
        } else {
            
            return (self.view.frame.size.width * 0.1173)
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        if component == 0 {
            
            let data = "\(pickerData[row])"
            let title = NSAttributedString(string: data, attributes: [
                
                NSFontAttributeName: UIFont.systemFontOfSize(self.view.frame.size.height * 0.03748, weight: UIFontWeightBold)
                
                ])
            
            label.attributedText = title
            
            label.textAlignment = .Center
            
            return label
            
        }
        
        if component == 1 {
            
            let data = "\(pickerData[row])"
            let title = NSAttributedString(string: data, attributes: [
                
                NSFontAttributeName: UIFont.systemFontOfSize(self.view.frame.size.height * 0.03748, weight: UIFontWeightBold)
                
                ])
            
            label.attributedText = title
            
            label.textAlignment = .Center
            
            return label
            
            
        } else {
            
            let data = decimalPercentages[row]
            
            if let dataString = formatter.stringFromNumber(data) {
                
                let titleString = ".\(dataString)%"
                
                let title = NSAttributedString(string: titleString, attributes: [
                    
                    NSFontAttributeName: UIFont.systemFontOfSize(self.view.frame.size.height * 0.03748, weight: UIFontWeightBold)
                    
                    ])
                
                label.attributedText = title
                
                label.textAlignment = .Center
                
            }
            
            return label
            
            
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        years = Double(self.pickerView.selectedRowInComponent(0) + 1)
        interestPercentage = Double(self.pickerView.selectedRowInComponent(1) + 1)
        decimalInterestPerentage = Double(self.pickerView.selectedRowInComponent(2))
        
        self.calculate()
        
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return (self.view.frame.size.height * 0.06596)
    }
    
    func setUpPickerViewComponents() {
        
        self.pickerView.showsSelectionIndicator = true
        
        let formatter = NSNumberFormatter()
        
        formatter.minimumIntegerDigits = 2
        
        for i in 1...99 {
            
            pickerData.append(i)
            
        }
        
        for i in 0...99 {
            
            decimalPercentages.append(i)
            
        }
        
    }
    
    func updateUI() {
        
        if let initialAmountString = formatter.stringFromNumber(initialAmount) {
            
            self.initialAmountLabel.text = initialAmountString
            
        }
        
        self.monthlyDepositLabel.text = "\(self.monthlyDeposit)"
        
        let years = self.pickerView.selectedRowInComponent(0) + 1
        
        let interestPercentage = self.pickerView.selectedRowInComponent(1) + 1
        
        let decimalInterestPerentage = self.pickerView.selectedRowInComponent(2)
        
        if let decimalInterestPercentageString = self.formatter.stringFromNumber(decimalInterestPerentage) {
            
            self.yearsToSaveLabel.text = "\(years)"
            
            self.annualInterestLabel.text = "\(interestPercentage).\(decimalInterestPercentageString)%"
            
        }
        
    }
    
    func calculate() {
        
        let years = self.pickerView.selectedRowInComponent(0) + 1
        let interestPercentage = self.pickerView.selectedRowInComponent(1) + 1
        let decimalInterestPercentage = self.pickerView.selectedRowInComponent(2)
        
        
        self.updateUI()
        
        
    }
    
    @IBAction func numberTapped(sender: UIButton) {
        
        if let initialAmountString = formatter.stringFromNumber(initialAmount), monthlyDepositString = formatter.stringFromNumber(monthlyDeposit) {
            
            if self.labelToChange == "Initial Amount" {
                
                if initialAmountString.characters.count < 9 {
                    
                    self.initialAmount = (initialAmount * 10) + Double(sender.tag)
                    
                }
                
            } else {
                
                if monthlyDepositString.characters.count < 9 {
                    
                    self.monthlyDeposit = (monthlyDeposit * 10) + Double(sender.tag)
                    
                }
                
            }
            
            self.updateUI()
            
        }
        
    }
    
    @IBAction func decimalTapped(sender: UIButton) {
        
        print("decimal tapped")
        
        self.updateUI()
        
    }
    
    @IBAction func clearTapped(sender: UIButton) {
        
        if self.labelToChange == "Monthly Deposit" {
            
            self.monthlyDeposit = 0
            
        } else {
            
            self.initialAmount = 0
            
        }
        
        self.updateUI()
        
    }
    
    @IBAction func monthlyDepositButtonTapped(sender: UIButton) {
        
        self.initialAmountButton.backgroundColor = .clearColor()
        self.labelToChange = "Monthly Deposit"
        self.monthlyDepositButton.backgroundColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.00)
        
    }
    
    
    @IBAction func initialAmountButtonTapped(sender: UIButton) {
        
        self.monthlyDepositButton.backgroundColor = .clearColor()
        self.labelToChange = "Initial Amount"
        self.initialAmountButton.backgroundColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.00)
        
    }
    
}

