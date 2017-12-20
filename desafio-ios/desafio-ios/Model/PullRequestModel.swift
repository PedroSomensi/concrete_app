//
//  PullRequestModel.swift
//  desafio-ios
//
//  Created by Pedro on 03/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation
import ObjectMapper

class PullRequest {
    
    var user_PR: UserPullRequest?
    var info_PR: InfoPullRequest?
    var repository: Repository?
    
    init(user: UserPullRequest, info: InfoPullRequest, repo: Repository) {
        user_PR = user
        info_PR = info
        repository = repo
    }
    
}

struct UserPullRequest: Mappable {
    
    var name_user: String?
    var image_user: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name_user <- map["login"]
        image_user <- map["avatar_url"]
        
    }
    
    init(name: String, image: String) {
        name_user = name
        image_user = image
    }
    
}

struct InfoPullRequest: Mappable {
    
    var title_pr: String?
    var body_pr: String?
    var data_pr: String?
    var pageWebUrl: String?
    

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        title_pr <- map["title"]
        body_pr <- map["body"]
        data_pr <- map["created_at"]
        pageWebUrl <- map["html_url"]
    }
    
    init(title: String, body: String, data: String, url: String) {
        title_pr = title
        body_pr = body
        data_pr = data
        pageWebUrl = url
    }
}

struct Repository: Mappable {
    
    var name_repository: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name_repository <- map["full_name"]
    }
    
    init(name: String) {
        name_repository = name
    }
    
}
