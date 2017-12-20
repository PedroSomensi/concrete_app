//
//  APIService.swift
//  desafio-ios
//
//  Created by Pedro on 01/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIService : NSObject {
    
    private static var controlRequest : ControlLoad = .incomplete
    
    static func loadRepositories(page: Int, complete : @escaping ([User]) -> Void) {
        if APIService.controlRequest == .incomplete {
            Alamofire.request(WebServices.respositories.setPage(page: page)).responseJSON { response in switch response.result {
                
            case .success(let data):
                guard let jsonString = convertToJSONString(from: data) else { return }
                guard let dict = convertToDictionary(text: jsonString) else { return }
                guard let items = dict["items"] as? [[String: Any]] else { return }
                
                
                guard let statusControlRequest = dict["incomplete_results"] as? Int else { return }
                self.setControlRequest(status: statusControlRequest)
                
                var users : [User] = []
                for item in items {
                    guard let ownerString = convertToJSONString(from: item["owner"] ?? "") else { return }
                    guard let ownerRepo = Mapper<Owner>().map(JSONString: ownerString) else { return }
                    guard let userGitHub = Mapper<UserGitHub>().map(JSON: item) else { return }
                    
                    let user = User(user: userGitHub, owner: ownerRepo)
                    users.append(user)
                }
                
                complete(users)
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
            }
        } else {
            print("sorry, all data downloaded")
        }
    }
    
    static func loadPullRequest(username: String, name_repo: String, complete: @escaping ([PullRequest]) -> Void) {
        
        let url = "https://api.github.com/repos/\(username)/\(name_repo)/pulls"
        
        Alamofire.request(url).responseJSON { response in switch response.result {
            
            case .success(let data):
                guard let jsonString = convertToJSONString(from: data) else { return }
                guard let arrayJson = convertToArray(text: jsonString) else { return }
            
                var pullrequests : [PullRequest] = []
                for item in arrayJson {
                    //mapping info InfoPullRequest
                    guard let jsonString = convertToJSONString(from: item) else { return }
                    guard let info_pr = Mapper<InfoPullRequest>().map(JSONString: jsonString) else { return }
                    
                    
                    //mapping UserPullRequest
                    guard let dict = convertToDictionary(text: jsonString) else { return }
                    guard let json_piece_user = convertToJSONString(from: dict["user"] ?? "") else { return }
                    guard let user_pr = Mapper<UserPullRequest>().map(JSONString: json_piece_user) else { return }
                    
                    
                    //mapping Repository
                    guard let jsonString_piece_head = convertToJSONString(from: dict["head"] ?? "") else { return }
                    guard let json_piece_head = convertToDictionary(text: jsonString_piece_head) else { return }
                    
                    var repo: Repository
                    
                    if json_piece_head["repo"] is NSNull {
                        repo = Repository(name: "Repository Null")
                    } else {
                        guard let jsonString_piece_head_repo = convertToJSONString(from: json_piece_head["repo"] ?? "") else { return }
                        guard let repository = Mapper<Repository>().map(JSONString: jsonString_piece_head_repo) else { return }
                        repo = repository
                    }
                    
                    let pullrequest = PullRequest(user: user_pr, info: info_pr, repo: repo)
                    pullrequests.append(pullrequest)
                }
            
                complete(pullrequests)
            
            case .failure(let error):
                print("Request failed with error: \(error)")
            
            }
        }
        
    }
    
    
    func stopLoadData() {
        APIService.controlRequest = .complete
    }
    
    func getStatusControlRequest() -> ControlLoad {
        return APIService.controlRequest
    }
    
    private static func setControlRequest(status: Int) {
        switch status {
        case 0:
            APIService.controlRequest = .incomplete
        case 1:
            APIService.controlRequest = .complete
        default:
            break
        }
    }
    
}

extension APIService {
    
    enum WebServices : String {
        case respositories
        
        func setPage(page: Int) -> String {
            switch self {
            case .respositories:
                return "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=\(page)" as String
            }
        }
        
    }
    
    enum ControlLoad {
        case incomplete
        case complete
    }
}
