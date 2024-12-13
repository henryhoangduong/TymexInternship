//
//  GitHubUserViewModel.swift
//  GithubUser
//
//  Created by mac on 13/12/2567 BE.
//
import Foundation

class GitHubViewModel: ObservableObject {
    @Published var users: [GitHubUser] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var userData: GitHubUser? = nil

    private var currentUser = 100
    private var numbOfUser = 20

    func fetchGitHubUsers() async {
        let endpoint = "https://api.github.com/users?per_page=\(numbOfUser)&since=\(currentUser)"

        guard let url = URL(string: endpoint) else {
            errorMessage = "Invalid URL"
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                errorMessage = "Invalid response"
                return
            }

            let decoder = JSONDecoder()
            let users = try decoder.decode([GitHubUser].self, from: data)

            DispatchQueue.main.async {
                self.users = users
                self.isLoading = false
                self.currentUser += self.numbOfUser
            }

        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error fetching data: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }

    func fetchGitHubUser(by username: String) async {
        let endpoint = "https://api.github.com/users/\(username)"

        guard let url = URL(string: endpoint) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response or status code"
                }
                return
            }

            let decoder = JSONDecoder()
            let user = try decoder.decode(GitHubUser.self, from: data)

            DispatchQueue.main.async {
                self.userData = user
            }

        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error fetching user data: \(error.localizedDescription)"
            }
        }
    }
}
