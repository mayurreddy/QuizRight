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
        bindToViewModel()
        viewModel.refresh()
    }
    
    private func bindToViewModel() {
        viewModel.allRecords.asObservable()
            .bind(to: contentView.table.rx.items(
                cellIdentifier: LocalRecordsViewCell.identifier,
                cellType: LocalRecordsViewCell.self
            )) { row, record, cell in
                print("Iam being binded")
            }.disposed(by: bag)
    }
}
