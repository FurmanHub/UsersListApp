//
//  UsersListViewController.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol UsersListDisplayLogic: class {
    func displaySomething(viewModel: UsersList.Something.ViewModel)
}

class UsersListViewController: UIViewController, UsersListDisplayLogic {
    var interactor: UsersListBusinessLogic?
    var router: (NSObjectProtocol & UsersListRoutingLogic & UsersListDataPassing)?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = UsersList.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: UsersList.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    
    // MARK: View Layout
    
    private func setupUI() {
        self.title = NSLocalizedString("Users", comment: "")
        self.tabBarItem.image = UIImage(named: "tab_users")
        self.tabBarItem.selectedImage = UIImage(named: "tab_users_active")
    }
}
