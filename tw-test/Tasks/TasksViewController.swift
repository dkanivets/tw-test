//
//  TasksViewController.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel: TasksViewModel
    
    init (viewModel: TasksViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "TasksViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTasks))
        navigationItem.rightBarButtonItem = add
        self.viewModel.updateTasksAction.apply(self.viewModel.taskList.id).on(completed: { [weak self] in
            self?.tableView.reloadData()
        }).start()
    }
    
    @objc func showAddTasks() {
        let addTasksVM = AddTasksViewModel(taskList: viewModel.taskList)
        let addTasksVC = AddTasksViewController(viewModel: addTasksVM)
        self.navigationController?.pushViewController(addTasksVC, animated: true)
    }

    private func configureTableView() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: MainTableViewCell.identifier)
    }
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.nameLabel.text = viewModel.items[indexPath.row].name
        cell.descriptionLabel.text = viewModel.items[indexPath.row].taskDescr
        cell.idLabel.text = viewModel.items[indexPath.row].id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
