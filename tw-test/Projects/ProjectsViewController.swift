//
//  ProjectsViewController.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 07.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    init() {
        super.init(nibName: "ProjectsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ProjectsService.pull(startFrom: 0, batch: 0).on(
            failed: { error in
                print(error)
            }, completed: {
                print("success")
            }).start()
    }

}
