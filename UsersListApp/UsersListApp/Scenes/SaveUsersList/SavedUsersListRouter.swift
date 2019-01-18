//
//  SavedUsersListRouter.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

@objc protocol SavedUsersListRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SavedUsersListDataPassing {
    var dataStore: SavedUsersListDataStore? { get }
}

final class SavedUsersListRouter: NSObject, SavedUsersListRoutingLogic, SavedUsersListDataPassing {
    weak var viewController: SavedUsersListViewController?
    var dataStore: SavedUsersListDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: SavedUsersListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: SavedUsersListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
