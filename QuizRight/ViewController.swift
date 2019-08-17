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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        let levelsButton = createButton()
        levelsButton.setTitle("Levels", for: .normal)
        
        levelsButton.rx.tap.subscribe(onNext: {
            let vc = StageListVC()
            self.present(vc, animated: true)
        }).disposed(by: bag)
        
        let continueButton = createButton()
        continueButton.setTitle("Continue", for: .normal)
        
        continueButton.rx.tap.subscribe(onNext: {
            let firstStage = StageOne()
            let vm = StageVM(stage: firstStage)
            let vc = StageVC(viewModel: vm)
            self.present(vc, animated: true)
        }).disposed(by: bag)
        
        let recordsButton = createButton()
        recordsButton.setTitle("Records", for: .normal)
        
        stack.addArrangedSubview(levelsButton)
        stack.addArrangedSubview(continueButton)
        stack.addArrangedSubview(recordsButton)
        
        view.addSubview(stack)
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        button.backgroundColor = .primaryOrange
        button.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(80)
        }
        button.layer.cornerRadius = 10
        return button
    }
}

