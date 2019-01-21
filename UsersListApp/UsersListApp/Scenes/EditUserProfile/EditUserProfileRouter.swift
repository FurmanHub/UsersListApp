//
//  EditUserProfileRouter.swift
//  UsersListApp
//
//  Created by Fedya on 1/20/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

@objc protocol EditUserProfileRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol EditUserProfileDataPassing {
    var dataStore: EditUserProfileDataStore? { get }
}

final class EditUserProfileRouter: NSObject, EditUserProfileRoutingLogic, EditUserProfileDataPassing {
    weak var viewController: EditUserProfileViewController?
    var dataStore: EditUserProfileDataStore?
    
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
    
    //func navigateToSomewhere(source: EditUserProfileViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: EditUserProfileDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
