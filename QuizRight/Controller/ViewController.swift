//
//  ViewController.swift
//  QuizRight
//
//  Created by Mayur on 8/8/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let bag = DisposeBag()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        let levelsButton = createButton()
        levelsButton.setTitle("Play", for: .normal)
        
        levelsButton.rx.tap.subscribe(onNext: {
            let vc = StageListVC()
            self.present(vc, animated: true)
        }).disposed(by: bag)
        
        let recordsButton = createButton()
        recordsButton.setTitle("Records", for: .normal)
        
        recordsButton.rx.tap.subscribe(onNext: {
            let vc = LocalRecordsVC()
            self.present(vc, animated: true)
        }).disposed(by: bag)
        
        stack.addArrangedSubview(levelsButton)
        stack.addArrangedSubview(recordsButton)
        
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.view = view
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        button.backgroundColor = .primaryOrange
        button.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.height.equalTo(70)
        }
        button.layer.cornerRadius = 10
        return button
    }
}

