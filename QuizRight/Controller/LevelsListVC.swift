//
//  LevelsListVC.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit

class LevelsListVC: UIViewController {
    
    private let viewModel = StageListVM()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private lazy var navBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.barTintColor = .primaryOrange
        bar.isTranslucent = false
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let navItem = UINavigationItem(title: "Levels")
        let backItem = UIBarButtonItem(title: "Back",
                                       style: .done,
                                       target: self,
                                       action: #selector(goBack(_:)))
        backItem.tintColor = .white
        navItem.setLeftBarButton(backItem, animated: false)
        bar.setItems([navItem], animated: false)
        bar.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        return bar
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .primaryOrange
        view.addSubview(navBar)
        view.addSubview(table)
        
        navBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        table.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension LevelsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let stage = viewModel.getStage(for: index)
        let stageVM = StageVM(stage: stage)
        let vc = StageVC(viewModel: stageVM)
        present(vc, animated: true)
    }
}

extension LevelsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getStageCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "a")
        let index = indexPath.row
        let stage = viewModel.getStage(for: index)
        cell.textLabel?.text = stage.name
        cell.detailTextLabel?.text = stage.description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension LevelsListVC {
    @objc func goBack(_ sender: Any?) {
        dismiss(animated: true)
    }
}
