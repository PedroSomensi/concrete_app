//
//  ViewController.swift
//  desafio-ios
//
//  Created by Pedro on 01/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private var page = 1
    
    
    var dataSource: UserTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.startAnimating()
        tableView.isHidden = true
        self.setupTableView()
        tableView.delegate = self
    }
    
    func setupTableView() {
        APIService.loadRepositories(page: self.page) { (users) in
            self.dataSource = UserTableViewDataSource(items: users, tableview: self.tableView, delegate: self)
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.ActivityIndicator.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let countItems = self.dataSource?.items.count else { return }
        if indexPath.row == countItems-1 {
            self.page += 1
            APIService.loadRepositories(page: self.page, complete: { (users) in
                self.dataSource?.updateDataSource(newItems: users)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBorad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBorad.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        viewController.name_repo = dataSource?.getNameOfRepo(index: indexPath.row)
        viewController.username_owner = dataSource?.getNameOwnerOfRepo(index: indexPath.row)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}




