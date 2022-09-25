//
//  ViewController.swift
//  Rgba
//
//  Created by Jorgen Shiller on 25.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var coloredView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var sliderRed: UISlider!
    @IBOutlet var sliderGreen: UISlider!
    @IBOutlet var sliderBlue: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliderRed()
        setupSliderGreen()
        setupSliderBlue()
    }

    @IBAction func redSlider() {
        redLabel.text = "Red: \(round(sliderRed.value * 100) / 100)"
        coloredView.backgroundColor = UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: 1)
    }
    
    @IBAction func greenSlider() {
        greenLabel.text = "Green: \(round(sliderGreen.value * 100) / 100)"
        coloredView.backgroundColor = UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: 1)
    }
    
    @IBAction func blueSlider() {
        blueLabel.text = "Blue: \(round(sliderBlue.value * 100) / 100)"
        coloredView.backgroundColor = UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: 1)
    }
    
    private func setupSliderRed() {
        sliderRed.value = 0
        sliderRed.minimumValue = 0
        sliderRed.maximumValue = 1
}
    private func setupSliderGreen() {
        sliderGreen.value = 0
        sliderGreen.minimumValue = 0
        sliderGreen.maximumValue = 1
}
    private func setupSliderBlue() {
        sliderBlue.value = 0
        sliderBlue.minimumValue = 0
        sliderBlue.maximumValue = 1
}
}

