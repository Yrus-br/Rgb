//
//  ViewController.swift
//  Rgba
//
//  Created by Jorgen Shiller on 25.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: NewColorDelegate!
    var updatedColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 30
        
        setSliderValue()
        setColor()
        setValueToTF()
        setValueToLabel()
        addDoneButtonToTF()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: IBactions
    
    @IBAction func doneButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        case greenSlider:
            greenLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        default:
            blueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        }
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        switch sender {
        case redTextField:
            let redTFvalue = Float(redTextField.text!) ?? 0.0
            redSlider.setValue(redTFvalue, animated: true)
            
            if redTFvalue > 1 || redTextField.text == "" {
                wrongFormat(title: "Wrong Format!", message: "Plese enter the correct value")
            }
            
        case greenTextField:
            let greenTFvalue = Float(greenTextField.text!) ?? 0.0
            greenSlider.setValue(greenTFvalue, animated: true)
            
            if greenTFvalue > 1 || greenTextField.text == ""{
                wrongFormat(title: "Wrong Format!", message: "Plese enter the correct value")
            }
            
        default:
            let blueTFvalue = Float(blueTextField.text!) ?? 0.0
            blueSlider.setValue(blueTFvalue, animated: true)
            
            if blueTFvalue > 1 || blueTextField.text == "" {
                wrongFormat(title: "Wrong Format!", message: "Plese enter the correct value")
            }
        }
        setColor()
        setValueToLabel()
        setValueToTF()
    }
    
    // MARK: methods
    
    func setColor() {
        let colorForView = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        colorView.backgroundColor = colorForView
        delegate?.setBackgroundColor(to: colorForView)
    }
    
    private func addDoneButtonToTF() {
        redTextField.addDoneButtonToKeyboard(
            action:#selector(redTextField.resignFirstResponder)
        )
        greenTextField.addDoneButtonToKeyboard(
            action:  #selector(greenTextField.resignFirstResponder)
        )
        blueTextField.addDoneButtonToKeyboard(
            action:  #selector(blueTextField.resignFirstResponder)
        )
    }
    
    private func setValueToLabel() {
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
    }
    
    private func setValueToTF() {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    private func setSliderValue() {
        let sligerColor = CIColor(color: updatedColor)
        redSlider.value = Float(sligerColor.red)
        greenSlider.value = Float(sligerColor.green)
        blueSlider.value = Float(sligerColor.blue)
        colorView.backgroundColor = UIColor(ciColor: sligerColor)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func wrongFormat(
        title: String,
        message: String,
        textField: UITextField? = nil
    )
    {
        let message = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        message.addAction(okButton)
        present(message, animated: true)
    }
}

// MARK: extensions

extension UITextField {
    func addDoneButtonToKeyboard(action:Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(
            frame:
                CGRect(
                    x: 0,
                    y: 0,
                    width: 300,
                    height: 40
                )
        )
        
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil, action: nil
        )
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self, action: action
        )
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}
