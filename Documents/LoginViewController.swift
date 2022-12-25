//
//  LoginViewController.swift
//  Documents
//
//  Created by Андрей Васильев on 21.12.2022.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {

    private let passwordtextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray6
        field.placeholder = "password"
        field.textColor = .black
        field.font = . systemFont(ofSize: 16)
        field.tintColor = .systemBlue
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.isSecureTextEntry = true
        field.indent(size: 10)
        field.toAutoLayout()
        return field
    }()

    private let passwordButton = CustomButton(title: "",
                                              titleColor: .white,
                                              backgroundColor: .systemBlue,
                                              cornerRadius: 10)

    private func layout() {
        view.addSubviews(passwordtextField, passwordButton)
        NSLayoutConstraint.activate([

            passwordtextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            passwordtextField.heightAnchor.constraint(equalToConstant: 50),
            passwordtextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordtextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordButton.topAnchor.constraint(equalTo: passwordtextField.bottomAnchor, constant: 16),
            passwordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    func screenStatus() {

        if KeychainSwift().allKeys.count == 0 {
            self.passwordButton.setTitle("Создать пароль", for: .normal)
        } else {
            self.passwordButton.setTitle("Введите пароль", for: .normal)
        }

    }

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        layout()
        KeychainSwift().clear()
        screenStatus()
        passwordButton.target = {self.tap()}

    }

    @objc
    func tap() {
        let text = passwordtextField.text!
        var characterText = [Character]()
        for character in text {
            characterText.append(character)
        }
        if passwordButton.currentTitle == "Создать пароль" {
            if characterText.count > 3 {
                KeychainSwift().set(passwordtextField.text!, forKey: "userPassword")
                let alert = UIAlertController(title: "Пароль сохранен!", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Отлично", style: .default, handler: { action in
                    self.passwordButton.setTitle("Введите пароль", for: .normal)
                    self.passwordtextField.text = ""
                }))
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Некорректный пароль!", message: "Пароль меньше 4 символов", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Исправить", style: .default, handler: { action in
                    self.passwordtextField.text = ""
                }))
                self.present(alert, animated: true)
            }
        } else {
            if passwordButton.currentTitle == "Введите пароль" {

                if passwordtextField.text == KeychainSwift().get("userPassword") {
                    self.passwordButton.setTitle("Повторите пароль", for: .normal)
                    self.passwordtextField.text = ""
                } else {
                    let alert = UIAlertController(title: "Неверный пароль!", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Исправить", style: .default, handler: { action in
                        self.passwordtextField.text = ""
                    }))
                    self.present(alert, animated: true)
                }

            } else {
                if passwordButton.currentTitle == "Повторите пароль" {
                    if passwordtextField.text == KeychainSwift().get("userPassword") {
                        let vc = MainTabBarController()
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = vc
                    } else {
                        let alert = UIAlertController(title: "Неверный пароль!", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Исправить", style: .default, handler: { action in
                            self.passwordButton.setTitle("Введите пароль", for: .normal)
                            self.passwordtextField.text = ""
                        }))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }

}
