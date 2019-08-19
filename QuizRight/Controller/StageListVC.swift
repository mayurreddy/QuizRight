//
//  StageListVC.swift
//  QuizRight
//
//  Created by Mayur on 8/12/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import UIKit

class StageListVC: UIViewController {
    
    private let viewModel = StageListVM()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.register(StageListViewCell.self, forCellReuseIdentifier: StageListViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var navBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.barTintColor = .white
        bar.isTranslucent = false
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let navItem = UINavigationItem(title: "Levels")
        let backItem = UIBarButtonItem(title: "Back",
                                       style: .done,
                                       target: self,
                                       action: #selector(goBack(_:)))
        backItem.tintColor = .black
        navItem.setLeftBarButton(backItem, animated: false)
        bar.setItems([navItem], animated: false)
        bar.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        return bar
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stageStore.refresh()
        table.reloadData()
    }
}

extension StageListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let stage = viewModel.getStage(for: index)
        let stageVM = StageVM(stage: stage)
        let vc = StageVC(viewModel: stageVM)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension StageListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getStageCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: StageListViewCell.identifier) as! StageListViewCell
        let index = indexPath.row
        let stage = viewModel.getStage(for: index)
        cell.nameLabel.text = stage.name
        cell.descLabel.text = stage.description
        if let personalBest = stageStore.getPersonalBestForStage(id: stage.id) {
            cell.bestLabel.text = "\(personalBest)"
        }
        return cell
        
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "a")
//        let index = indexPath.row
//        let stage = viewModel.getStage(for: index)
//        cell.textLabel?.text = stage.name
//        cell.detailTextLabel?.text = stage.description
//        cell.accessoryType = .disclosureIndicator
//        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension StageListVC {
    @objc func goBack(_ sender: Any?) {
        dismiss(animated: true)
    }
}
