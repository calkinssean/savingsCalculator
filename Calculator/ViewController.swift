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
    
    var valueToChange = "Initial Amount"
    
    var initialAmountDecimalIsTapped = false
    var monthlyDepositDecimalIsTapped = false
    
    var initialAmount: Double = 0
    var initialAmountIntegers: Double = 0
    var initialAmountFractionalDigits: Double = 0
    
    var initialAmountIntegerTaps = 0
    var InitialAmountfractionalDigitTaps = 0
    
    var monthlyDeposit: Double = 0
    var monthlyDepositIntegers: Double = 0
    var monthlyDepositFractionalDigits: Double = 0
    
    var monthlyDepositIntegerTaps = 0
    var monthlyDepositFractionalDigitTaps = 0
    
    var years: Double = 0
    var interestPercentage: Double = 0
    var decimalInterestPerentage: Double = 0
    var annualInterest: Double = 0
    var interestEarned: Double = 0
    var amountSaved: Double = 0
    
    let formatter = NSNumberFormatter()
    
    let initialAmountFormatter = NSNumberFormatter()
    let monthlyDepositFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialAmountFormatter.minimumFractionDigits = 0
        self.monthlyDepositFormatter.minimumFractionDigits = 0
        
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
            
            let data = Double(decimalPercentages[row]) * 0.01
            
            formatter.maximumIntegerDigits = 0
            formatter.minimumFractionDigits = 2
            
            if let dataString = formatter.stringFromNumber(data) {
                
                let titleString = "\(dataString)%"
                
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
        
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if self.initialAmount == 0 {
            
            self.initialAmountLabel.text = ""
            
        } else {
            
            if let initialAmountString = initialAmountFormatter.stringFromNumber(self.initialAmount) {
                
                self.initialAmountLabel.text = initialAmountString
                
            }
            
        }
        
        if self.monthlyDeposit == 0 {
            
            self.monthlyDepositLabel.text = ""
            
        } else {
            
            if let monthlyDepositString = monthlyDepositFormatter.stringFromNumber(self.monthlyDeposit) {
                
                self.monthlyDepositLabel.text = monthlyDepositString
                
            }
            
        }
        
        let years = self.pickerView.selectedRowInComponent(0) + 1
        
        let interestPercentage = self.pickerView.selectedRowInComponent(1) + 1
        
        let decimalInterestPerentage: Double = Double(self.pickerView.selectedRowInComponent(2)) * 0.01
        
        let interestRate = Double(interestPercentage) + Double(decimalInterestPerentage)
        
        formatter.maximumIntegerDigits = 10
        
        if let interestRateString = formatter.stringFromNumber(interestRate) {
            
            self.annualInterestLabel.text = "\(interestRateString)%"
            
        }
        
        self.yearsToSaveLabel.text = "\(years)"
        
        if let interestEarnedString = formatter.stringFromNumber(interestEarned) {
            
            self.interestEarnedLabel.text = "$\(interestEarnedString)"
            
        }
        
        if let amountSavedString = formatter.stringFromNumber(amountSaved) {
            
            self.amountSavedLabel.text = "$\(amountSavedString)"
            
        }
        
        
        
    }
    
    func calculate() {
        
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        let interestPercentage = self.pickerView.selectedRowInComponent(1) + 1
        let decimalInterestPercentage = self.pickerView.selectedRowInComponent(2)
        
        self.initialAmount = self.initialAmountIntegers + (self.initialAmountFractionalDigits * 0.01)
        self.monthlyDeposit = self.monthlyDepositIntegers + (self.monthlyDepositFractionalDigits * 0.01)
        
        /*
         
         Compound interest for principal:
         P(1+r/n)^nt
         
         Future value of a series:
         PMT * (((1 + r/n)^nt - 1) / (r/n)) * (1+r/n)
         
         A = the future value of the investment/loan, including interest
         P = the principal investment amount (the initial deposit or loan amount)
         PMT = the monthly payment
         r = the annual interest rate (decimal)
         n = the number of times that interest is compounded per year AND additional payment frequency
         t = the number of years the money is invested or borrowed for
         
         */
        
        let P = self.initialAmount
        
        //print("Principal: \(P)")
        
        let r: Double = (Double(interestPercentage) + (Double(decimalInterestPercentage) * 0.01)) * 0.01
        
        //print("Interest Rate: \(r)")
        
        let n: Double = 12
        
        //print("Interest is compounded \(n) times a year")
        
        let t = Double(self.pickerView.selectedRowInComponent(0) + 1)
        
        //print("Calculating interest for \(t) years")
        
        let PMT = self.monthlyDeposit
        
        //print("Monthly Payment is \(PMT)")
        
        // P(1+r/n)^nt
        let A = P * pow(( 1 + ( r / n )), (n * t))
        
        // PMT * (((1 + r/n)^nt - 1) / (r/n)) * (1+r/n)
        let FV = PMT * ((pow((1 + r/n), (n * t)) - 1) / (r/n))
        
        self.interestEarned = (A - P) + (FV - PMT * (n * t))
        
        self.amountSaved = (FV + A)
        
        self.updateUI()
        
    }
    
    @IBAction func numberTapped(sender: UIButton) {
        
        if self.valueToChange == "Initial Amount" {
            
            if self.initialAmountDecimalIsTapped == true {
                
                if self.InitialAmountfractionalDigitTaps < 2 {
                    
                    if self.InitialAmountfractionalDigitTaps == 0 {
                        
                        self.initialAmountFractionalDigits = Double(sender.tag) * 10
                        
                    }
                    
                    if self.InitialAmountfractionalDigitTaps == 1 {
                        
                        self.initialAmountFractionalDigits = self.initialAmountFractionalDigits + Double(sender.tag)
                        
                    }
                    
                    self.InitialAmountfractionalDigitTaps += 1
                    
                }
                
            } else {
                
                if self.initialAmountIntegerTaps < 9 {
                    
                    self.initialAmountIntegers = (self.initialAmount * 10) + Double(sender.tag)
                    
                    self.initialAmountIntegerTaps += 1
                    
                }
            }
        }
        
        if valueToChange == "Monthly Deposit" {
            
            if monthlyDepositDecimalIsTapped == true {
                
                if self.monthlyDepositFractionalDigitTaps < 2 {
                    
                    if self.monthlyDepositFractionalDigitTaps == 0 {
                        
                        self.monthlyDepositFractionalDigits = Double(sender.tag) * 10
                        
                    }
                    
                    if self.monthlyDepositFractionalDigitTaps == 1 {
                        
                        self.monthlyDepositFractionalDigits = self.monthlyDepositFractionalDigits + Double(sender.tag)
                        
                    }
                    
                    self.monthlyDepositFractionalDigitTaps += 1
                    
                }
                
            } else {
                
                if self.monthlyDepositIntegerTaps < 9 {
                    
                    self.monthlyDepositIntegers = (self.monthlyDeposit * 10) + Double(sender.tag)
                    
                    self.monthlyDepositIntegerTaps += 1
                    
                }
            }
        }
        
        self.calculate()
        
    }
    
    @IBAction func decimalTapped(sender: UIButton) {
        
        if self.valueToChange == "Initial Amount" {
            
            self.initialAmountDecimalIsTapped = true
            self.initialAmountFormatter.minimumFractionDigits = 2
            
        }
        
        if self.valueToChange == "Monthly Deposit" {
            
            self.monthlyDepositDecimalIsTapped = true
            self.monthlyDepositFormatter.minimumFractionDigits = 2
            
        }
        
        
        self.updateUI()
        
        
    }
    
    @IBAction func clearTapped(sender: UIButton) {
        
        if self.valueToChange == "Monthly Deposit" {
            
            self.monthlyDepositFormatter.minimumFractionDigits = 0
            
            self.monthlyDepositDecimalIsTapped = false
            
            self.monthlyDepositIntegers = 0
            self.monthlyDepositFractionalDigits = 0
            
            self.monthlyDepositIntegerTaps = 0
            self.monthlyDepositFractionalDigitTaps = 0
            
        }
        
        if self.valueToChange == "Initial Amount" {
            
            self.initialAmountFormatter.minimumFractionDigits = 0
            
            self.initialAmountDecimalIsTapped = false
            
            self.initialAmountIntegers = 0
            self.initialAmountFractionalDigits = 0
            
            self.initialAmountIntegerTaps = 0
            self.InitialAmountfractionalDigitTaps = 0
            
        }
        
        self.calculate()
        
    }
    
    @IBAction func monthlyDepositButtonTapped(sender: UIButton) {
        
        self.initialAmountButton.backgroundColor = .clearColor()
        self.valueToChange = "Monthly Deposit"
        self.monthlyDepositButton.backgroundColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.00)
        
    }
    
    
    @IBAction func initialAmountButtonTapped(sender: UIButton) {
        
        self.monthlyDepositButton.backgroundColor = .clearColor()
        self.valueToChange = "Initial Amount"
        self.initialAmountButton.backgroundColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.00)
        
    }
    
}

