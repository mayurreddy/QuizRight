//
//  GradientView.swift
//  QuizRight
//
//  Created by Mayur on 8/23/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit

class GradientView: UIView {
    private let gradient = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor
    
    init(gradientStartColor: UIColor, gradientEndColor: UIColor) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }
    
    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientEndColor.cgColor, gradientStartColor.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0.2, y: 1)
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
        gradient.cornerRadius = self.layer.cornerRadius
    }
}
