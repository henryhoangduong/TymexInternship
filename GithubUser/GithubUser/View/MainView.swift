//
//  MainView.swift
//  GithubUser
//
//  Created by mac on 12/12/2567 BE.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = GitHubViewModel() // Bind ViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("GitHub Users")
                    .font(.largeTitle)
                    .padding()

                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: DetailView(userName: user.login)) {
                            HStack {
                                AsyncImage(url: URL(string: user.avatar_url)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }

                                VStack(alignment: .leading) {
                                    Text(user.login)
                                        .font(.headline)
                                    Divider()
                                    if let url = URL(string: user.html_url) {
                                        Link(user.html_url, destination: url)
                                            .foregroundColor(.blue)
                                            .padding(.top)
                                    }
                                }
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .onAppear {
                            if user == viewModel.users.last {
                                Task {
                                    await viewModel.fetchGitHubUsers()
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }

            }
            .onAppear {
                Task {
                    viewModel.isLoading = true
                    await viewModel.fetchGitHubUsers()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
