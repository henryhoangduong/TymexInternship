//
//  GithubViewModelTests.swift
//  GithubUser
//
//  Created by mac on 13/12/2567 BE.
//

import XCTest
@testable import GithubUser

class GitHubViewModelTests: XCTestCase {
    
    var viewModel: GitHubViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = GitHubViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchGitHubUsersSuccess() async {

        await viewModel.fetchGitHubUsers()
        
        XCTAssertFalse(viewModel.users.isEmpty, "Users should not be empty.")
        XCTAssertNil(viewModel.errorMessage, "There should be no error.")
    }
    
    func testFetchGitHubUsersFailure() async {
        viewModel.errorMessage = nil
        viewModel.isLoading = true
        
        await viewModel.fetchGitHubUsers()
        
        if let errorMessage = viewModel.errorMessage {
            XCTAssertTrue(errorMessage.starts(with: "Error fetching data"), "Error message should start with 'Error fetching data'.")
        } else {
            XCTFail("Error message should not be nil on failure.")
        }
    }
    
    func testFetchGitHubUserDetailSuccess() async {
        let username = "octocat"
        await viewModel.fetchGitHubUser(by: username)
        
        XCTAssertNotNil(viewModel.userData, "User data should be populated.")
        XCTAssertEqual(viewModel.userData?.login, username, "The username should match the fetched data.")
    }
    
    func testFetchGitHubUserDetailFailure() async {
        let username = "invalidusername"
        await viewModel.fetchGitHubUser(by: username)
        
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set when user fetch fails.")
    }
    }
    

