//
//  ProjectsTableViewCell.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    static let identifier = "mainCellIdentifier"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
}
