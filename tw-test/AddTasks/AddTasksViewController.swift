//
//  AddTasksViewController.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import ARSLineProgress

class AddTasksViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: AddTasksViewModel
    
    init(viewModel: AddTasksViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "AddTasksViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.updateUI()
        self.viewModel.items.signal.observeValues { [weak self] _ in
            self?.tableView.reloadData()
        }

    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
    private func updateUI() {
        let submitButton = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(addTasks))
        navigationItem.rightBarButtonItem = submitButton
        textField.delegate = self
        self.title = "Add tasks"
    }

    @objc func addTasks() {
        ARSLineProgress.show()
        
        viewModel.addTasksAction.apply((taskNames: viewModel.items.value.joined(separator: "\n"), taskListID: viewModel.taskList.id, projectID: viewModel.taskList.projectID)).on(
        failed: { error in
            ARSLineProgress.showFail()
        },
        completed: {
            self.navigationController?.popViewController(animated: true)
            print("Success")
        }).start()
    }
}

extension AddTasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        cell.nameLabel.text = viewModel.items.value[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.viewModel.items.value.remove(at: indexPath.row)
    }
}

extension AddTasksViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let taskName = textField.text {
            viewModel.items.value.append(taskName)
            textField.text = ""
        }
        
        return true
    }
}
