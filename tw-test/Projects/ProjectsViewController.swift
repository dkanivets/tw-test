//
//  ProjectsViewController.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 07.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage
import ARSLineProgress

class ProjectsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ProjectsViewModelProtocol
    
    init() {
        self.viewModel = ProjectsViewModel()

        super.init(nibName: "ProjectsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.configureUI()
        self.viewModel.updateItemsAction.apply().on(
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

    private func configureUI() {
        self.title = "Projects"
    }

    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: MainTableViewCell.identifier)
    }

}

extension ProjectsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.nameLabel.text = viewModel.items[indexPath.row].name
        cell.descriptionLabel.text = viewModel.items[indexPath.row].projectDescr
        cell.idLabel.text = viewModel.items[indexPath.row].id
        cell.logo.sd_setImage(with: URL(string: viewModel.items[indexPath.row].logo), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let project = viewModel.items[indexPath.row]
        let projectVM = ProjectDetailsViewModel(project: project)
        let projectVC = ProjectViewController(viewModel: projectVM)
        self.navigationController?.pushViewController(projectVC, animated: true)
    }
}
