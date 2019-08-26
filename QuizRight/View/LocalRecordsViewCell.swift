//
//  LocalRecordsViewCell.swift
//  QuizRight
//
//  Created by Mayur on 8/22/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit

class LocalRecordsViewCell: UITableViewCell {
    
    static let identifier = "LocalRecordsViewCell"
    
    private let fontColor = UIColor.white
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = fontColor
        return label
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(fontColor, for: .normal)
        return button
    }()
    
    let bestLabel = UILabel()
    let attemptsLabel = UILabel()
    let successRateLabel = UILabel()
    let averageTimeLabel = UILabel()
    
    private let stackOfLabels = UIStackView()
    private lazy var notAttemptedLabel: UILabel = {
        let label = UILabel()
        label.text = "No records found"
        label.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        label.textColor = fontColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bgView = GradientView(gradientStartColor: UIColor(rgb: 0x3A7BD5),
                                  gradientEndColor: UIColor(rgb: 0x3A6073))
        bgView.layer.cornerRadius = 10
        
        addSubview(bgView)
        bgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        
        bgView.addSubview(nameLabel)
        bgView.addSubview(resetButton)
        bgView.addSubview(notAttemptedLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
        }
        
        resetButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalTo(nameLabel)
        }
        
        notAttemptedLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        let bestTimeStack = createVStack(title: "Personal Best",
                                         label: bestLabel)
        
        let totalAttemptsStack = createVStack(title: "Total Attempts",
                                              label: attemptsLabel)
        
        let topStack = createHStack(one: bestTimeStack,
                                    two: totalAttemptsStack)
        
        let successRateStack = createVStack(title: "Success Rate",
                                            label: successRateLabel)
        
        let averageTimeStack = createVStack(title: "Average Time",
                                            label: averageTimeLabel)
        
        let bottomStack = createHStack(one: successRateStack,
                                       two: averageTimeStack)

        stackOfLabels.axis = .vertical
        stackOfLabels.distribution = .fillEqually
        stackOfLabels.addArrangedSubview(topStack)
        stackOfLabels.addArrangedSubview(bottomStack)
        bgView.addSubview(stackOfLabels)
        
        stackOfLabels.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        [topStack, bottomStack].forEach { stack in
            stack.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        attemptsLabel.text = ""
        averageTimeLabel.text = ""
        successRateLabel.text = ""
    }
    
    func setLabelDisplay(stageNotAttempted: Bool) {
        stackOfLabels.isHidden = stageNotAttempted
        resetButton.isHidden = stageNotAttempted
        notAttemptedLabel.isHidden = !stageNotAttempted
    }
    
    private func createVStack(title: String, label: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        let titleLabel = UILabel()
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        titleLabel.text = title
        titleLabel.textColor = fontColor
        stack.addArrangedSubview(titleLabel)
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = fontColor
        stack.addArrangedSubview(label)
        return stack
    }
    
    private func createHStack(one: UIStackView, two: UIStackView) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.addArrangedSubview(one)
        stack.addArrangedSubview(two)
        return stack
    }
}
