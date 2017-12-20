//
//  PullRequestTableViewDataSource.swift
//  desafio-ios
//
//  Created by Pedro on 03/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation
import UIKit

final class PullRequestTableViewDataSource: NSObject, UITableViewDataSource {
    
    var items: [PullRequest] = []
    weak var tableView: UITableView?
    weak var delegate: UITableViewDelegate?
    
    required init(items: [PullRequest], tableview: UITableView, delegate: UITableViewDelegate) {
        self.items = items
        self.tableView = tableview
        self.delegate = delegate
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestCell", for: indexPath) as! PullRequestTableViewCell
        cell.setup(pullrequest: items[indexPath.row])
        return cell
    }
    
}

