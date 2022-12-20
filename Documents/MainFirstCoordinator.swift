//
//  RootCoordinator.swift
//  Navigation
//
//  Created by Андрей Васильев on 09.11.2022.
//

import Foundation
import UIKit


final class MainFirstCoordinator: AppCoordinator {

    var childs =  [AppCoordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = FirstViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func childDidFinish(_ child: AppCoordinator?) {
        for (index, appcoordinator) in childs.enumerated() {
            if appcoordinator === child {
                childs.remove(at: index)
                break
            }
        }
    }

}
