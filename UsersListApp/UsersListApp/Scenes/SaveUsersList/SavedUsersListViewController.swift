//
//  SavedUsersListViewController.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol SavedUsersListDisplayLogic: class {
    func displaySavedUsers(viewModel: SavedUsersList.fetchSavedUsers.ViewModel)
}

class SavedUsersListViewController: UIViewController, SavedUsersListDisplayLogic, UITableViewDelegate, UITableViewDataSource {
    private var interactor: SavedUsersListBusinessLogic?
    private var router: (NSObjectProtocol & SavedUsersListRoutingLogic & SavedUsersListDataPassing)?
    private let userCellIdentifier = "UserCell"
    private let savedUsersTable = UITableView()
    private var displayedSavedUsers: [SavedUsersList.fetchSavedUsers.ViewModel.DisplayedUser] = []
    
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
        let interactor = SavedUsersListInteractor()
        let presenter = SavedUsersListPresenter()
        let router = SavedUsersListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        setupUI()
    }
    
    // MARK: Routing
    
    
    // MARK: View lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchSavedUsers()
    }
    
    // MARK: Fetch saved users from local database
    
    func fetchSavedUsers() {
        interactor?.fetchUsersFromLocalDB()
    }
    
    func displaySavedUsers(viewModel: SavedUsersList.fetchSavedUsers.ViewModel) {
        displayedSavedUsers = viewModel.displayedUsers
        reloadTable()
    }
    
    // MARK: View Layout
    
    private func setupUI() {
        self.title = NSLocalizedString("Saved", comment: "")
        self.tabBarItem.image = UIImage(named: "tab_saved")
        self.tabBarItem.selectedImage = UIImage(named: "tab_saved_active")
        setupSavedUsersTable()
    }
    
    private func setupSavedUsersTable() {
        savedUsersTable.register(UserCell.self, forCellReuseIdentifier: userCellIdentifier)
        savedUsersTable.dataSource = self
        savedUsersTable.delegate = self
        savedUsersTable.separatorColor = .gray
        savedUsersTable.rowHeight = 60
        view.install(savedUsersTable) { _ in
            savedUsersTable.pinTop(to: view)
            savedUsersTable.pinLeading(to: view)
            savedUsersTable.pinBottom(to: view)
            savedUsersTable.pinTrailing(to: view)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSavedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as! UserCell
        cell.configure(with: displayedSavedUsers[indexPath.row])
        return cell
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.savedUsersTable.reloadData()
        }
    }
    
}
