//
//  TableViewHelper.swift
//  e-commerce-app
//
//  Created by Esra Türk on 20.10.2024.
//

import Foundation
import UIKit

class TableViewHelper {
  
    static func showEmptyCartMessage(on tableView: UITableView, with message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        messageLabel.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
        messageLabel.center = tableView.center

        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }
}

