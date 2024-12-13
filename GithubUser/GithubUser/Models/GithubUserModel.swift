//
//  GithubUserModel.swift
//  GithubUser
//
//  Created by mac on 12/12/2567 BE.
//
import Foundation

struct GitHubUser: Codable, Identifiable, Equatable {
    let id: String = UUID().uuidString
    let login: String
    let avatar_url: String
    let html_url: String
    let location: String?
    let followers: Int?
    let following: Int?
}
