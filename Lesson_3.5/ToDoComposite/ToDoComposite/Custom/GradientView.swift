//
//  GradientView.swift
//  ToDoComposite
//
//  Created by Сергей Чумовских  on 20.12.2021.
//

import UIKit

class MainGradiendView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let colors = [
            UIColor(red: 0.000, green: 0.949, blue: 0.376, alpha: 1),
            UIColor(red: 0.020, green: 0.459, blue: 0.902, alpha: 1)
            ]
        
        let colorTop = colors.first!.cgColor
        let colorBottom = colors.last!.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
