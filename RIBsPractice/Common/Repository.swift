//
//  Repository.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/02.
//

import Foundation

struct Repository {
    
    let id: Int
    let name: String
    let fullName: String
    let url: String
    let language: String?
    
    let ownerAvatarUrl: String
    let ownerLogin: String
    let owerUrl: String
    
}

struct RepositoryResult: Codable {
    
    let items: [RepositoryResponse]
    init(
        items: [RepositoryResponse]
    ) {
        self.items = items
    }
}

struct RepositoryResponse: Codable {
    
    let id: Int
    let name: String
    let full_name: String
    let url: String
    let language: String?
    let owner: OwnerItem
    
    init(
        id: Int,
        name: String,
        full_name: String,
        url: String,
        language: String?,
        owner: OwnerItem
    ) {
        self.id = id
        self.name = name
        self.full_name = full_name
        self.url = url
        self.language = language
        self.owner = owner
    }
    
    func toRepository() -> Repository {
        return Repository(id: self.id,
                          name: self.name,
                          fullName: self.full_name,
                          url: self.url,
                          language: self.language,
                          ownerAvatarUrl: self.owner.avatar_url,
                          ownerLogin: self.owner.login,
                          owerUrl: self.owner.url)
    }
}


struct OwnerItem: Codable {
    
    let login: String
    let id: Int
    let url: String
    let avatar_url: String
    
    init(
        avatar_url: String,
        url: String,
        id: Int,
        login: String
    ) {
        self.avatar_url = avatar_url
        self.url = url
        self.id = id
        self.login = login
    }
}
