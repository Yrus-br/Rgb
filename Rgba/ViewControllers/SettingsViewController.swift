//
//  ViewController.swift
//  Rgba
//
//  Created by Jorgen Shiller on 25.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
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
    
    //MARK: Public properties
    var delegate: NewColorDelegate!
    var updatedColor: UIColor!
    
    //MARK: View life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 30
        colorView.backgroundColor = updatedColor
        
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: IBactions
    
    @IBAction func doneButtonPressed() {
        delegate.setBackgroundColor(to: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        setColor()
    }
    
    // MARK: methods
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
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
    
    private func showAlert(
        title: String,
        message: String,
        textField: UITextField? = nil
    )
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKaction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "1.00"
            textField?.becomeFirstResponder()
        }
        alert.addAction(OKaction)
        present(alert, animated: true)
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: updatedColor)
        colorSliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redSlider)
            case greenTextField: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for colorLabels: UILabel...) {
        colorLabels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
}


// MARK: extensions

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(title: "Wrong format", message: "Plese enter the correct number")
            return
        }
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                title: "Wrong format",
                message: "Plese enter the correct number",
                textField: textField
            )
            return
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexButtonSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        
        keyboardToolBar.items = [flexButtonSpace, doneButton]
    }
}
