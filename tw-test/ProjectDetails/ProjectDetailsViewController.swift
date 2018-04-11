//
//  ProjectViewController.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit
import ARSLineProgress

class ProjectDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var defaultPrivacy: UILabel!

    let viewModel: ProjectDetailsViewModelProtocol
    
    init (viewModel: ProjectDetailsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: "ProjectDetailsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.updateUI()
        
        self.viewModel.updateItemsAction.apply(self.viewModel.project.id).on(
            starting: {
                ARSLineProgress.show()
            },
            failed: { _ in
                ARSLineProgress.showFail()
            },
            completed: { [weak self] in
                ARSLineProgress.showSuccess()
                self?.tableView.reloadData()
            }).start()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    private func updateUI() {
        self.title = viewModel.project.name
        startDateLabel.text = "Started: \(self.dateFrom(string: viewModel.project.createdOn))"
        statusLabel.text = " " + viewModel.project.status + " "
        defaultPrivacy.text = " " + viewModel.project.defaultPrivacy + " "
        projectDescriptionLabel.text = self.viewModel.project.projectDescr
        logoImageView.sd_setImage(with: URL(string: self.viewModel.project.logo), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    private func dateFrom(string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-dd-yyyy HH:mm"
        
        if let date = dateFormatterGet.date(from: string){
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}

extension ProjectDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.nameLabel.text = viewModel.items[indexPath.row].name
        cell.descriptionLabel.text = viewModel.items[indexPath.row].tasksListDescr
        cell.idLabel.text = viewModel.items[indexPath.row].id
        
        if cell.logo.superview != nil && cell.stackView.arrangedSubviews.count > 1 {
            cell.stackView.removeArrangedSubview(cell.logo.superview!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tasks lists"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let taskList = viewModel.items[indexPath.row]
        let taskVM = TasksViewModel(taskList: taskList)
        let tasktVC = TasksViewController(viewModel: taskVM)
        self.navigationController?.pushViewController(tasktVC, animated: true)
    }
}
