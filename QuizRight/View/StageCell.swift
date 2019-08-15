//
//  StageCell.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit

class StageCell: UICollectionViewCell {
    
    static var identifier = "StageCell"
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.primaryBlack.cgColor
        
        let textLabel = UILabel()
        self.contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.lessThanOrEqualToSuperview()
        }
        
        self.textLabel = textLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel.textAlignment = .center
        self.backgroundColor = .white
    }
}
