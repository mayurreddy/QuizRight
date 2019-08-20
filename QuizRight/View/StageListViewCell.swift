//
//  StageListViewCell.swift
//  QuizRight
//
//  Created by Mayur on 8/19/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit

class StageListViewCell: UITableViewCell {
    
    static let identifier = "StageListViewCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    let bestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
//
//    private lazy var nameStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.alignment = .leading
//        stack.addArrangedSubview(nameLabel)
//        stack.addArrangedSubview(descLabel)
//        return stack
//    }()
    
    private lazy var superStack: UIView = {
        let stack = UIView()
        stack.addSubview(nameLabel)
        stack.addSubview(descLabel)
        stack.addSubview(bestLabel)
        bestLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        descLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom)
        }
        return stack
    }()
    
    private let bgView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        bgView.backgroundColor = .lightOrange
        bgView.layer.cornerRadius = 10
        bgView.addSubview(superStack)
        superStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        addSubview(bgView)
        bgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        descLabel.text = ""
        bestLabel.text = ""
    }

}
