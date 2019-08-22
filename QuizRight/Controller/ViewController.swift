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
    private let viewModel = HomeScreenVM()
    
    private lazy var loginToGCButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Login to Game Center", for: .normal)
        button.setTitleColor(.primaryOrange, for: .normal)
        
        viewModel.isGKPlayerAuthenticated.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isAuthenticated in
                button.isHidden = isAuthenticated
            })
            .disposed(by: bag)
        
        button.rx.tap.subscribe(onNext: {
            self.viewModel.attemptAuthentication()
        })
        .disposed(by: bag)
        
        return button
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
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
        view.addSubview(loginToGCButton)
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        loginToGCButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loginToGameCenterVC.asObservable()
            .subscribe(onNext: { vc, err in
                if let vc = vc {
                    self.present(vc, animated: true)
                } else if let error = err {
                    // TODO
                }
            })
            .disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkAuthentication()
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        button.backgroundColor = .primaryOrange
        button.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.height.equalTo(70)
        }
        button.layer.cornerRadius = 10
        return button
    }
}

