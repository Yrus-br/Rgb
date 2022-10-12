//
//  MainViewController.swift
//  Rgba
//
//  Created by Jorgen Shiller on 11.10.2022.
//

import UIKit

protocol NewColorDelegate {
    func setBackgroundColor(to color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.updatedColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: NewColorDelegate {
    func setBackgroundColor(to color: UIColor) {
        view.backgroundColor = color
    }
}
