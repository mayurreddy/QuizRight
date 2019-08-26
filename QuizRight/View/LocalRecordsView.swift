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
    
    private lazy var navBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.barTintColor = .white
        bar.isTranslucent = false
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let navItem = UINavigationItem(title: "Personal Records")
        navItem.setLeftBarButton(backItem, animated: false)
        bar.setItems([navItem], animated: false)
        return bar
    }()
    
    lazy var backItem: UIBarButtonItem = {
        let backItem = UIBarButtonItem(title: "Back",
                                       style: .done,
                                       target: nil,
                                       action: nil)
        backItem.tintColor = .black
        return backItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(navBar)
        addSubview(table)
        
        navBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        table.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func goBack(_ sender: UIBarButtonItem) {
        print("I have been clicked")
    }
}
