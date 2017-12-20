//
//  SecondViewController.swift
//  desafio-ios
//
//  Created by Pedro on 03/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var username_owner : String?
    var name_repo : String?
    
    var dataSource : PullRequestTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        self.activityIndicator.startAnimating()
        self.setupTableView()
        tableView.delegate = self
        
        
        self.navigationItem.title = "Pull Requests"
    }
    
    func setupTableView() {
        if username_owner != "" && name_repo != "" {
            APIService.loadPullRequest(username: username_owner ?? "", name_repo: name_repo ?? "") { (pullrequests) in
                self.dataSource = PullRequestTableViewDataSource(items: pullrequests, tableview: self.tableView, delegate: self)
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let endPoint = dataSource?.items[indexPath.row].info_PR?.pageWebUrl else { return }
        loadWebPage(endPoint: endPoint)
    }
    
    func loadWebPage(endPoint: String) {
        guard let url = URL(string: endPoint) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
