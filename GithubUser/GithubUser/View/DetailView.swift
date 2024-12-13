import SwiftUI

struct DetailView: View {
    let userName: String
    @StateObject var viewModel = GitHubViewModel() // Use the same view model to fetch data
    @State private var isLoading = true

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            if let user = viewModel.userData {
                HStack {
                    AsyncImage(url: URL(string: user.avatar_url)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment:.leading){
                        
                        Text(user.login)
                            .font(.title)
                            .multilineTextAlignment(.center)
                        Divider()
                        if let location = user.location {
                            Text("Location: \(location)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal,10)
                HStack(spacing:20){
                    if let followers = user.followers {
                        Text("\(followers)+ \nFollowers")
                            .font(.system(size: 20))  // Set font size to 22 points
                            .bold()                   // Make text bold
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)

                    }

                    if let following = user.following {
                        Text("\(following)+\nFollowing")
                            .font(.system(size: 20))  // Set font size to 22 points
                            .bold()                   // Make text bold
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            
                    }

                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Blog")
                        .font(.title)
                    
                    if let url = URL(string: user.html_url) {
                        Link(user.html_url, destination: url)
                            .foregroundColor(.blue)
                            .padding(.top)
                    }
                }
                .padding(.horizontal,20)
                .frame(maxWidth: .infinity, alignment: .leading)




            } else if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }

        .frame(maxWidth: .infinity)
        .navigationTitle("User Details")
        .onAppear {
            Task {
                await fetchUserData()
            }
        }
    }


    private func fetchUserData() async {
        await viewModel.fetchGitHubUser(by: userName)
        isLoading = false
    }

}

#Preview {
    DetailView(userName: "jvantuyl")
}
