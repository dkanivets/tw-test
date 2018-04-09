//
//  ProjectViewController.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel: ProjectDetailsViewModelProtocol
    
    init (viewModel: ProjectDetailsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: "ProjectViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.viewModel.updateItemsAction.apply(self.viewModel.project.id).on(completed: { [weak self] in
            self?.tableView.reloadData()
        }).start()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: MainTableViewCell.identifier)
    }
}

extension ProjectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.nameLabel.text = viewModel.items[indexPath.row].name
        cell.descriptionLabel.text = viewModel.items[indexPath.row].tasksListDescr
        cell.idLabel.text = viewModel.items[indexPath.row].id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let taskList = viewModel.items[indexPath.row]
        let taskVM = TasksViewModel(taskList: taskList)
        let tasktVC = TasksViewController(viewModel: taskVM)
        self.navigationController?.pushViewController(tasktVC, animated: true)
    }
}
