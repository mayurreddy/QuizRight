//
//  LocalRecordsVC.swift
//  QuizRight
//
//  Created by Mayur on 8/22/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LocalRecordsVC: UIViewController {
    
    private let contentView = LocalRecordsView()
    private let viewModel = LocalRecordsVM()
    private let bag = DisposeBag()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backItem.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: bag)
        
        contentView.table.rx.setDelegate(self).disposed(by: bag)
        bindToViewModel()
        viewModel.refresh()
    }
    
    private func bindToViewModel() {
        viewModel.allRecords.asObservable()
            .bind(to: contentView.table.rx.items(
                cellIdentifier: LocalRecordsViewCell.identifier,
                cellType: LocalRecordsViewCell.self
            )) { _, record, cell in
                
                cell.nameLabel.text = record.name
                cell.setLabelDisplay(stageNotAttempted: !record.didAttempt)
                guard record.didAttempt else {
                    return
                }

                self.configure(cell, from: record)
            }.disposed(by: bag)
    }
    
    private func configure(_ cell: LocalRecordsViewCell, from record: StageRecord) {
        cell.attemptsLabel.text = "\(record.totalAttempts)"
        cell.bestLabel.text = record.personalBest == nil ? "--.-" : "\(record.personalBest!)s"
        
        let averageSuccessTime: String
        if var averageTime = record.averageSuccessTime {
            averageTime = Double(round(averageTime * 100) / 100)
            averageSuccessTime = "\(averageTime)s"
        } else {
            averageSuccessTime = "--.-"
        }
        cell.averageTimeLabel.text = averageSuccessTime
        
        var successRate = record.successRate
        successRate = Double(round(successRate * 1000) / 10)
        cell.successRateLabel.text = "\(successRate)%"
        
        cell.resetButton.rx.tap.subscribe(onNext: {
            stageStore.resetStage(id: record.id)
            self.viewModel.refresh()
            self.contentView.table.reloadData()
        }).disposed(by: bag)
    }
}

extension LocalRecordsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
