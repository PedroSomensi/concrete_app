//
//  UserTableViewDataSource.swift
//  desafio-ios
//
//  Created by Pedro on 02/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation
import UIKit

final class UserTableViewDataSource: NSObject, UITableViewDataSource {
    
    var items: [User] = []
    weak var tableView: UITableView?
    weak var delegate: UITableViewDelegate?
    
    required init(items: [User], tableview: UITableView, delegate: UITableViewDelegate) {
        self.items = items
        self.tableView = tableview
        self.delegate = delegate
        super.init()
    }
    
    func updateDataSource(newItems: [User]) {
        for newItem in newItems {
            self.items.append(newItem)
        }
        self.tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.setup(user: items[indexPath.row])
        return cell
    }
    
    func getNameOwnerOfRepo(index: Int) -> String? {
        return items[index].ownerRepo?.name
    }
    
    func getNameOfRepo(index: Int) -> String? {
        return items[index].userGitHub?.name_repository
    }
    
}
