//  User.swift
//  GHub Squad
//  Created by George Garcia on 1/4/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import Foundation

struct User: Codable {
    
    var login:       String
    var avatarUrl:   String
    var name:        String?
    var location:    String?
    var bio:         String?
    var htmlUrl:     String
    var createdAt:   String
    var publicRepos: Int
    var publicGists: Int
    var following:   Int
    var followers:   Int
}
