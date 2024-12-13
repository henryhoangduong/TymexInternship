//
//  ApiServices.swift
//  GithubUser
//
//  Created by mac on 12/12/2567 BE.
//

import Foundation

func fetchGitHubUsers() {
    guard let url = URL(string: "https://api.github.com/users?per_page=20&since=100") else {
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }

        guard let data = data else {
            print("No data received")
            return
        }

        do {
            let decoder = JSONDecoder()
            let users = try decoder.decode([GitHubUser].self, from: data)

            for user in users {
                print("Username: \(user.login), ID: \(user.id), Avatar URL: \(user.avatar_url)")
            }
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    task.resume()
}
