//  User.swift
//  GHub Squad
//  Created by George Garcia on 1/4/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import Foundation

struct User: Codable {
    
    let login:       String
    let avatarUrl:   String
    var name:        String?
    var location:    String?
    var bio:         String?
    let htmlUrl:     String
    let createdAt:   String
    let publicRepos: Int
    let publicGists: Int
    let following:   Int
    let followers:   Int
}
