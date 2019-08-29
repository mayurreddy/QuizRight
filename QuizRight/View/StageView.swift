//
//  StageView.swift
//  QuizRight
//
//  Created by Mayur on 8/19/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation
import UIKit

class StageView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.layer.borderColor = UIColor.primaryBlack.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10
        view.register(StageCell.self, forCellWithReuseIdentifier: StageCell.identifier)
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.primaryOrange, for: .normal)
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .primaryOrange
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        button.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        return button
    }()
    
    lazy var nextButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 24
        stack.addArrangedSubview(self.retryButton)
        stack.addArrangedSubview(self.nextButton)
        stack.isHidden = true
        return stack
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryOrange
        button.layer.cornerRadius = 10
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryOrange
        button.layer.cornerRadius = 10
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        return button
    }()
    
    lazy var stageNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    lazy var stageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    lazy var elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    lazy var bestTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.text = "--.-"
        return label
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .primaryOrange
        label.isHidden = true
        return label
    }()
    
    private lazy var currentTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        let currentLabel = UILabel()
        currentLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        currentLabel.numberOfLines = 1
        currentLabel.text = "Current"
        stack.addArrangedSubview(currentLabel)
        stack.addArrangedSubview(elapsedTimeLabel)
        return stack
    }()
    
    private lazy var bestTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        let bestLabel = UILabel()
        bestLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        bestLabel.numberOfLines = 1
        bestLabel.text = "Best"
        stack.addArrangedSubview(bestLabel)
        stack.addArrangedSubview(bestTimeLabel)
        return stack
    }()
    
    private lazy var timeStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 48
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(currentTimeStack)
        stack.addArrangedSubview(bestTimeStack)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(stageNameLabel)
        addSubview(stageDescriptionLabel)
        addSubview(backButton)
        addSubview(startButton)
        addSubview(timeStack)
        addSubview(resultLabel)
        addSubview(nextButtonStack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContstraints(horizontal: UIUserInterfaceSizeClass,
                            vertical: UIUserInterfaceSizeClass) {
        
        guard let superview = superview else {
            print("View should installed in a superview")
            return
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(superview.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(70)
        }
        
        resultLabel.snp.makeConstraints {
            $0.center.width.equalTo(collectionView)
        }
        
        nextButtonStack.snp.makeConstraints {
            $0.centerX.equalTo(collectionView)
            $0.top.equalTo(resultLabel.snp.bottom).offset(30)
        }
        
        switch (horizontal, vertical) {
        case (.regular, .regular):
            let halfWidth = superview.bounds.width / 2.0
            let halfHeight = superview.bounds.height / 2.0
            let collectionViewDim = min(halfWidth, halfHeight)
            collectionView.snp.remakeConstraints {
                $0.bottom.equalToSuperview().inset(30)
                $0.width.height.equalTo(collectionViewDim)
                $0.centerX.equalToSuperview()
            }
            
            stageNameLabel.snp.remakeConstraints {
                $0.top.equalTo(superview.safeAreaLayoutGuide.snp.top).inset(25)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
            
            stageDescriptionLabel.snp.remakeConstraints {
                $0.top.equalTo(stageNameLabel.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }
            
            timeStack.axis = .horizontal
            timeStack.snp.remakeConstraints {
                $0.bottom.equalTo(collectionView.snp.top).inset(-30)
                $0.centerX.equalToSuperview()
            }
            
        case (.compact, .regular):
            let side = superview.bounds.width - 2.0 * 10.0
            collectionView.snp.remakeConstraints {
                $0.bottom.equalToSuperview().inset(10.0 + 20.0)
                $0.width.height.equalTo(side)
                $0.centerX.equalToSuperview()
            }
            
            stageNameLabel.snp.remakeConstraints {
                $0.top.equalTo(superview.safeAreaLayoutGuide.snp.top).inset(25)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
            
            stageDescriptionLabel.snp.remakeConstraints {
                $0.top.equalTo(stageNameLabel.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }
            
            timeStack.axis = .horizontal
            timeStack.snp.remakeConstraints {
                $0.bottom.equalTo(collectionView.snp.top).inset(-30)
                $0.centerX.equalToSuperview()
            }
            
        case (.regular, .compact), (.compact, .compact):
            let side = superview.bounds.height - 2.0 * 10.0
            collectionView.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalTo(side)
                $0.height.equalTo(side)
            }
            
            stageNameLabel.snp.remakeConstraints {
                $0.top.equalTo(superview.safeAreaLayoutGuide.snp.top).inset(10)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
            
            stageDescriptionLabel.snp.remakeConstraints {
                $0.top.equalTo(backButton.snp.bottom)
                $0.leading.equalToSuperview().inset(20)
                $0.trailing.equalTo(collectionView.snp.leading).inset(20)
                $0.bottom.equalToSuperview()
            }
            
            timeStack.axis = .vertical
            timeStack.snp.remakeConstraints {
                $0.leading.equalTo(collectionView.snp.trailing).inset(-40)
                $0.centerY.equalToSuperview()
            }
            
        default:
            let size = superview.bounds
            let dim = min(size.width, size.height)
            collectionView.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalTo(dim)
                $0.height.equalTo(collectionView.snp.width)
            }
        }
    }
}
