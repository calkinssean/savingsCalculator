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
    
    @IBOutlet var pickerView: UIPickerView!
    
    var pickerData = [Int]()
    var decimalPercentages = [Int]()
    let formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.view.frame.size)
      
        formatter.minimumIntegerDigits = 2
        
        self.setUpPickerViewComponents()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
}

