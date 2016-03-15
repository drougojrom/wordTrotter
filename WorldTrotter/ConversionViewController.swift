//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Roman Ustiantcev on 17/02/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var celsiusLabel1: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    var fahrenheitValue: Double?{
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel(){
        if let value = celsiusValue {
            celsiusLabel1.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel1.text = "???"
        }
    }
    
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField){
        
        if let text = textField.text, number = numberFormatter.numberFromString(text){
            fahrenheitValue = number.doubleValue
        } else {
            fahrenheitValue = nil
        }
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let hasAlphabet = NSCharacterSet.letterCharacterSet()
        if string.rangeOfCharacterFromSet(hasAlphabet) != nil {
            return false
            
        }
        
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
        
    }
    
    
    override func viewDidLoad() {
        // always need super
        super.viewDidLoad()
        print("conversion controller load this view")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let time = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let currentTime = formatter.stringFromDate(time)
        
        if currentTime.localizedUppercaseString.hasSuffix("PM") {
            backGroundView.backgroundColor = UIColor.grayColor()
        }
        
    }
    
}
