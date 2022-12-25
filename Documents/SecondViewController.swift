//
//  LogInViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 15.06.2022.
//

import UIKit


class SecondViewController: UIViewController {
    
    weak var coordinator: MainSecondCoordinator?

    let sortingLabel: UILabel = {
        let label = UILabel()
        label.text = "Сортировка файлов по алфавиту"
        label.font = .systemFont(ofSize: 18)
        label.toAutoLayout()
        return label
    }()

    let sortingSwitch: UISwitch = {
        let sortingSwitch = UISwitch()
        sortingSwitch.setOn(true, animated: true)
        UserDefaults.standard.set(true, forKey: "sort")
        sortingSwitch.toAutoLayout()
        return sortingSwitch
    }()

    let passwordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить пароль", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.toAutoLayout()
        return button
    }()

    func layout() {
        view.addSubviews(sortingLabel, sortingSwitch, passwordButton)

        NSLayoutConstraint.activate([

            sortingSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sortingSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sortingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sortingLabel.trailingAnchor.constraint(equalTo: sortingSwitch.leadingAnchor, constant: -16),
            sortingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sortingLabel.centerYAnchor.constraint(equalTo: sortingSwitch.centerYAnchor),
            passwordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordButton.topAnchor.constraint(equalTo: sortingSwitch.bottomAnchor, constant: 16),
            passwordButton.heightAnchor.constraint(equalToConstant: 50)

        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gearshape"), tag: 1)
        layout()
        self.sortingSwitch.addTarget(self, action: #selector(tapSwitch), for: .touchUpInside)
        self.passwordButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    @objc
    func tapSwitch() {
        if sortingSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "sort")
            print("on")
        } else {
            UserDefaults.standard.set(false, forKey: "sort")
            print("off")
        }
    }

    @objc
    func tap() {
        let vc = LoginViewController()
        present(vc, animated: true)
    }
    
}

