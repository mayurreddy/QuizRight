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
    private let contentView = StageView()
    
    // UI Constants
    private let inset = CGFloat(10)
    
    init(viewModel: StageVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        
        contentView.stageNameLabel.text = viewModel.getStageName()
        contentView.stageDescriptionLabel.text = viewModel.getStageDescription()

        contentView.backButton.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: bag)
        
        contentView.startButton.rx.tap.subscribe(onNext: {
            self.contentView.startButton.isHidden = true
            self.contentView.stageNameLabel.isHidden = true
            self.contentView.collectionView.isHidden = false
            self.viewModel.startCounter()
        }).disposed(by: bag)
        
        viewModel.elapsedTime.asObservable()
            .map { $0 < 0.0 ? "--.-" : String($0) }
            .bind(to: contentView.elapsedTimeLabel.rx.text)
            .disposed(by: bag)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let horizontalClass = view.traitCollection.horizontalSizeClass
        let verticalClass = view.traitCollection.verticalSizeClass
        contentView.updateContstraints(horizontal: horizontalClass,
                                       vertical: verticalClass)
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
    private func presentSuccessMessage() {
        contentView.collectionView.isHidden = true
        contentView.resultLabel.isHidden = false
        contentView.nextButtonStack.isHidden = false
        let elapsedTime = viewModel.elapsedTime.value
        let message = "Well Done! You finished the stage in \(elapsedTime) seconds"
        contentView.resultLabel.text = message
        stageStore.setStageElapsedTime(id: viewModel.id, time: elapsedTime)
    }
    
    private func presentFailureMessage() {
        contentView.collectionView.isHidden = true
        contentView.resultLabel.isHidden = false
        contentView.nextButtonStack.isHidden = false
        let message = "Oops! You chose a wrong option. Better luck next time"
        contentView.resultLabel.text = message
        stageStore.setStageFailure(id: viewModel.id)
    }
}
