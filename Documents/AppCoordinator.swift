//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Андрей Васильев on 09.11.2022.
//

import Foundation
import UIKit

protocol AppCoordinator: AnyObject {
    var childs: [AppCoordinator] {get set}
    var navigationController: UINavigationController {get set}

    func start()
}
