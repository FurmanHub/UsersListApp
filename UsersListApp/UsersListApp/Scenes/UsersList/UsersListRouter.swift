//
//  UsersListRouter.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

@objc protocol UsersListRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol UsersListDataPassing {
    var dataStore: UsersListDataStore? { get }
}

class UsersListRouter: NSObject, UsersListRoutingLogic, UsersListDataPassing {
    weak var viewController: UsersListViewController?
    var dataStore: UsersListDataStore?
    
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
    
    //func navigateToSomewhere(source: UsersListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: UsersListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
