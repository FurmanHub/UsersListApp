//
//  UsersListViewController.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol UsersListDisplayLogic: class {
    func displayFetchedUsers(viewModel: UsersList.FetchUsers.ViewModel)
}

final class UsersListViewController: UIViewController, UsersListDisplayLogic, UITableViewDataSource, UITableViewDelegate {
    private let userCellIdentifier = "UserCell"
    private let usersTable = UITableView()
    private var interactor: UsersListBusinessLogic?
    private var router: (NSObjectProtocol & UsersListRoutingLogic & UsersListDataPassing)?
    private var displayedUsers: [UsersList.FetchUsers.ViewModel.DisplayedUser] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = UsersListInteractor()
        let presenter = UsersListPresenter()
        let router = UsersListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        setupUI()
    }
    
    // MARK: Routing
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    // MARK: Fetch users
    
    private func fetchUsers() {
        let page = interactor?.requestPage ?? 0 + 1
        let request = UsersList.FetchUsers.Request(resultCount: 20, page: page)
        interactor?.fetchUsers(request: request)
    }
    
    func displayFetchedUsers(viewModel: UsersList.FetchUsers.ViewModel) {
        displayedUsers.append(contentsOf: viewModel.displayedUsers)
        reloadTable()
    }
    
    // MARK: View Layout
    
    private func setupUI() {
        self.title = NSLocalizedString("Users", comment: "")
        self.tabBarItem.image = UIImage(named: "tab_users")
        self.tabBarItem.selectedImage = UIImage(named: "tab_users_active")
        setupUsersTable()
    }
    
    private func setupUsersTable() {
        usersTable.register(UserCell.self, forCellReuseIdentifier: userCellIdentifier)
        usersTable.dataSource = self
        usersTable.delegate = self
        usersTable.separatorColor = .gray
        usersTable.rowHeight = 60
        view.install(usersTable) { _ in
            usersTable.pinTop(to: view)
            usersTable.pinLeading(to: view)
            usersTable.pinBottom(to: view)
            usersTable.pinTrailing(to: view)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == displayedUsers.count - 1) {
            fetchUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as! UserCell
        cell.configure(with: displayedUsers[indexPath.row])
        return cell
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.usersTable.reloadData()
        }
    }
}
