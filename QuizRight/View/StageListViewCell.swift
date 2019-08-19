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
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    let bestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    
    private lazy var nameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(descLabel)
        return stack
    }()
    
    private lazy var superStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.addArrangedSubview(nameStack)
        stack.addArrangedSubview(bestLabel)
        bestLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        nameStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
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
        bgView.snp.makeConstraints { $0.edges.equalToSuperview().inset(10) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
