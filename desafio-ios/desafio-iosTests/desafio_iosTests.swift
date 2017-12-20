//
//  desafio_iosTests.swift
//  desafio-iosTests
//
//  Created by Pedro on 01/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import XCTest
@testable import desafio_ios

class desafio_iosTests: XCTestCase {
    
    var viewController: ViewController!
    var secondController: SecondViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Controller") as! ViewController
        _ = viewController.view
        
        secondController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        _ = secondController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewDidLoadViewController() {
        viewController.viewDidLoad()
    }

    func testViewDidLoadSecondViewController() {
        secondController.viewDidLoad()
    }
    
    func testControlStopLoadDataFromAPIService() {
        let service = APIService()
        service.stopLoadData()
        let status = service.getStatusControlRequest()
        XCTAssertEqual(APIService.ControlLoad.complete, status)
    }
    
    func testTableViewRowHeightOfViewController() {
        XCTAssertEqual(viewController.tableView.rowHeight, 130)
    }
    
    func testTableViewRowHeightOfSecondViewController() {
        XCTAssertEqual(secondController.tableView.rowHeight, 150)
    }
    
    func testCountElementsInPullRequestTableViewAndDataSource() {
        let user_pr = UserPullRequest(name: "user", image: "xxxx.com")
        let info_pr = InfoPullRequest(title: "title", body: "body", data: "05/11/2017", url: "xxxx.com")
        let repo = Repository(name: "Repository")
        
        let PR = PullRequest(user: user_pr, info: info_pr, repo: repo)
        
        let pullRequests = [PR, PR, PR, PR]
        secondController.dataSource = PullRequestTableViewDataSource(items: pullRequests, tableview: secondController.tableView, delegate: secondController)
        secondController.tableView.dataSource = secondController.dataSource
        secondController.tableView.reloadData()
        
        XCTAssertEqual(secondController.tableView.numberOfRows(inSection: 0), secondController.dataSource?.items.count)
    }
    
    func testCountElementsInUserTableViewAndDataSource() {
        let userGitHub = UserGitHub(name: "UserGit", fullname: "GitHub", desc: "XXXX", star: 1, fork: 1)
        let owner = Owner(nick: "UserOwner", url: "xxxx.com")
        
        let user = User(user: userGitHub, owner: owner)
        
        let users = [user, user, user, user, user]
        viewController.dataSource = UserTableViewDataSource(items: users, tableview: viewController.tableView, delegate: viewController)
        viewController.tableView.dataSource = viewController.dataSource
        viewController.tableView.reloadData()
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), viewController.dataSource?.items.count)
    }
    
}
