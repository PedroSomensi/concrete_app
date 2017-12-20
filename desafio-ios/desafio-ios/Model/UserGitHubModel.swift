//
//  UserGitHub.swift
//  desafio-ios
//
//  Created by Pedro on 02/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation
import ObjectMapper

class User {
    
    var userGitHub: UserGitHub?
    var ownerRepo: Owner?
    
    init(user: UserGitHub, owner: Owner) {
        userGitHub = user
        ownerRepo = owner
    }
    
}

struct UserGitHub: Mappable {
    
    var name_repository: String?
    var full_name: String?
    var description_repository: String?
    var stars: Int?
    var forks: Int?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name_repository <- map["name"]
        description_repository <- map["description"]
        stars <- map["stargazers_count"]
        forks <- map["forks_count"]
        full_name <- map["full_name"]
    }
    
    init(name: String, fullname: String, desc: String, star: Int, fork: Int) {
        name_repository = name
        full_name = fullname
        description_repository = desc
        stars = star
        forks = fork
    }
}

struct Owner : Mappable {
    var name: String?
    var avatar_url: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["login"]
        avatar_url <- map["avatar_url"]
    }
    
    init(nick: String, url: String) {
        name = nick
        avatar_url = url
    }
}
