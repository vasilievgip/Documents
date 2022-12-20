//
//  LogInViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 15.06.2022.
//

import UIKit


class SecondViewController: UIViewController {
    
    weak var coordinator: MainSecondCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "square"), tag: 1)
    }
    
}

