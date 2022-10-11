//
//  MainViewController.swift
//  Rgba
//
//  Created by Jorgen Shiller on 11.10.2022.
//

import UIKit

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

extension MainViewController: NewColorForBackground {
    func setBackgroundColor(to color: UIColor) {
        view.backgroundColor = color
    }
}
