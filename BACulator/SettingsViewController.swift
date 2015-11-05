//
//  SettingsViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    @IBOutlet weak var setGenderTextField: UITextField!
    @IBOutlet weak var setWeightTextField: UITextField!
    @IBOutlet weak var doneButton: ODShadowButton!
    
  
    let defaults = DefaultsManager()
    let picker = UIPickerView()
    let pickerData = ["Male","Female","Undefined"]
    let imageArray = ["769-male", "768-female", "779-users"]
    var genderSelection : Int = 2
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
      
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        picker.delegate = self
        picker.dataSource = self
        setGenderTextField.inputView = picker
        setWeightTextField.delegate = self
        doneButton.hidden = true
        doneButton.userInteractionEnabled = false
        
        if(defaults.isSet(K_GENDER) && defaults.isSet(K_WEIGHT)){
            genderSelection = defaults.getGender()
            picker.selectedRowInComponent(genderSelection)
            setGenderTextField.text = pickerData[genderSelection]
            changeColorForGender(genderSelection)
            setWeightTextField.text = String(defaults.getWeight())
            doneButton.hidden = false
            doneButton.userInteractionEnabled = true
            
        }else{
            print("not set")
        }
     }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    

    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderSelection = row
        setGenderTextField.text = pickerData[row]
        
        let image = UIImage(named: imageArray[row])
        let imageView = UIImageView(image: image)
        for view in setGenderTextField.subviews{
            if (view is UIImageView) {
                view.removeFromSuperview()
            }
        }
        setGenderTextField.addSubview(imageView)
        changeColorForGender(row)
    }
    
   
    
    func changeColorForGender(row : Int){
        switch row {
        case 0 :
            picker.backgroundColor = UIColor(rgba: "#0099FF")
            setGenderTextField.backgroundColor = UIColor(rgba: "#0099FF")
        case 1 :
            picker.backgroundColor = UIColor(rgba: "#FF66FF")
            setGenderTextField.backgroundColor = UIColor(rgba: "#FF66FF")
        case 2 :
            picker.backgroundColor = UIColor(rgba: "#CC66FF")
            setGenderTextField.backgroundColor = UIColor(rgba: "#CC66FF")
            
        default :
            picker.backgroundColor = UIColor.darkGrayColor()
            setGenderTextField.backgroundColor = UIColor.darkGrayColor()
        }
    }
    
    
    @IBAction func doneButtonWasPressed(sender: AnyObject) {
            defaults.setGender(genderSelection)
            if let weight = setWeightTextField.text?.toDouble(){
                defaults.setWeight(weight)
                defaults.setGender(genderSelection)
            }else{
                doneButton.backgroundColor = UIColor.redColor()
                let alertController = UIAlertController(title: "Need input!", message:
                    "Please pick gender and set weight", preferredStyle: .Alert);
                let OKAction = UIAlertAction(title: "OK", style: .Default) {
                (action) in
                }
            alertController.addAction(OKAction)
             self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        setGenderTextField.resignFirstResponder()
        setWeightTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(setWeightTextField.text != nil && setGenderTextField.text != nil){
            doneButton.hidden = false
            doneButton.userInteractionEnabled = true
            doneButton.backgroundColor = UIColor.greenColor()
            setWeightTextField.resignFirstResponder()
            setGenderTextField.resignFirstResponder()
        }
    }
}
