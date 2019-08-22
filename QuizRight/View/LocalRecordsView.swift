//
//  LocalRecordsView.swift
//  QuizRight
//
//  Created by Mayur on 8/22/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit

class LocalRecordsView: UIView {
    let table: UITableView = {
        let table = UITableView()
        table.register(LocalRecordsViewCell.self, forCellReuseIdentifier: LocalRecordsViewCell.identifier)
        table.allowsSelection = false
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(table)
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
