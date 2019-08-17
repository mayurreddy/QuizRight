//
//  StageVC.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StageVC: UIViewController {
    
    private var viewModel: StageVM
    private let bag = DisposeBag()
    
    // UI Constants
    private let inset = CGFloat(10)
    
    init(viewModel: StageVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.layer.borderColor = UIColor.primaryBlack.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10
        view.delegate = self
        view.dataSource = self
        view.register(StageCell.self, forCellWithReuseIdentifier: StageCell.identifier)
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.primaryOrange, for: .normal)
        return button
    }()
    
    private lazy var startButton: UIButton = {
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
    
    private lazy var stageNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = self.viewModel.getStageName()
        return label
    }()
    
    private lazy var stageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.text = self.viewModel.getStageDescription()
        return label
    }()
    
    private lazy var elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .primaryOrange
        label.isHidden = true
        return label
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(stageNameLabel)
        view.addSubview(stageDescriptionLabel)
        view.addSubview(backButton)
        view.addSubview(startButton)
        view.addSubview(elapsedTimeLabel)
        view.addSubview(resultLabel)
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = StageMO.createFetchRequest()
        let stages = try! dataController.context.fetch(request)
        print("Received \(stages.count) stages")

        backButton.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: bag)
        
        startButton.rx.tap.subscribe(onNext: {
            self.startButton.isHidden = true
            self.stageNameLabel.isHidden = true
            self.collectionView.isHidden = false
            self.viewModel.startCounter()
        }).disposed(by: bag)
        
        viewModel.elapsedTime.asObservable()
            .map { $0 < 0.0 ? "--.-" : String($0) }
            .bind(to: elapsedTimeLabel.rx.text)
            .disposed(by: bag)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraints()
    }
}

extension StageVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard !viewModel.isStageComplete() else { return }
        guard let answer = viewModel.getOption(at: indexPath) else { return }
        
        if !viewModel.isCorrectAnswer(answer: answer) {
            viewModel.stopCounter()
            viewModel.elapsedTime.accept(-1.0)
            presentFailureMessage()
            return
        }
        
        collectionView.reloadItems(at: [indexPath])
        
        if viewModel.isStageComplete() {
            viewModel.stopCounter()
            presentSuccessMessage()
        }
    }
}

extension StageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTotalCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StageCell.identifier, for: indexPath) as! StageCell
        let option = viewModel.getOption(at: indexPath)!
        let color = viewModel.getBackgroundColor(for: indexPath)
        cell.textLabel.text = "\(option)"
        cell.backgroundColor = color
        return cell
    }
}

extension StageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = collectionView.bounds.width / CGFloat(viewModel.getDimension())
        return CGSize(width: dimension, height: dimension)
    }
}

extension StageVC {
    private func updateConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(70)
        }
        
        stageNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints {
            $0.center.width.equalTo(collectionView)
        }
        
        let horizontal = view.traitCollection.horizontalSizeClass
        let vertical = view.traitCollection.verticalSizeClass
        
        switch (horizontal, vertical) {
        case (.regular, .regular):
            let width = view.bounds.width / 2.0
            collectionView.snp.remakeConstraints {
                $0.bottom.equalToSuperview()
                $0.width.equalTo(width)
                $0.height.equalTo(width)
            }
            
            stageDescriptionLabel.snp.remakeConstraints {
                $0.top.equalTo(stageNameLabel.snp.bottom)
                $0.bottom.equalTo(collectionView.snp.top)
                $0.leading.trailing.equalToSuperview()
            }
            
        case (.compact, .regular):
            let side = view.bounds.width - 2.0 * inset
            collectionView.snp.remakeConstraints {
                $0.bottom.equalToSuperview().inset(inset + 20.0)
                $0.width.height.equalTo(side)
                $0.centerX.equalToSuperview()
            }
            
            stageDescriptionLabel.snp.remakeConstraints {
                $0.top.equalTo(stageNameLabel.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }
            
            elapsedTimeLabel.snp.remakeConstraints {
                $0.bottom.equalTo(collectionView.snp.top).inset(-30)
                $0.centerX.equalToSuperview()
            }
            
        case (.regular, .compact), (.compact, .compact):
            let side = view.bounds.height - 2.0 * inset
            collectionView.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalTo(side)
                $0.height.equalTo(side)
            }
            
            stageDescriptionLabel.snp.remakeConstraints {
                $0.top.equalTo(backButton.snp.bottom)
                $0.leading.equalToSuperview().inset(20)
                $0.trailing.equalTo(collectionView.snp.leading).inset(20)
                $0.bottom.equalToSuperview()
            }
            
            elapsedTimeLabel.snp.remakeConstraints {
                $0.leading.equalTo(collectionView.snp.trailing).inset(-40)
                $0.centerY.equalToSuperview()
            }
            
        default:
            let size = view.bounds
            let dim = min(size.width, size.height)
            collectionView.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalTo(dim)
                $0.height.equalTo(collectionView.snp.width)
            }
        }
    }
}

extension StageVC {
    private func presentSuccessMessage() {
        collectionView.isHidden = true
        resultLabel.isHidden = false
        let elapsedTime = viewModel.elapsedTime.value
        let message = "Well Done! You finished the stage in \(elapsedTime) seconds"
        resultLabel.text = message
    }
    
    private func presentFailureMessage() {
        collectionView.isHidden = true
        resultLabel.isHidden = false
        let message = "Oops! You chose a wrong option. Better luck next time"
        resultLabel.text = message
    }
}
