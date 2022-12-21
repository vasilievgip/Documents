//
//  ViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 10.04.2022.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate {

    weak var coordinator: MainFirstCoordinator?

    var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    var files : [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FirstViewCell.self, forCellReuseIdentifier: FirstViewCell.identifier)
        return tableView
    }()

    private let navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.toAutoLayout()
        return bar
    }()

    private let navigationBarButton_1: UIButton = {
        let button = UIButton()
        button.setTitle("Создать папку", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.toAutoLayout()
        return button
    }()

    private let navigationBarButton_2: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить фотографию", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.toAutoLayout()
        return button
    }()

    private func layout() {
        navigationBar.addSubviews(navigationBarButton_1, navigationBarButton_2)
        view.addSubviews(navigationBar, tableView)
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarButton_1.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
            navigationBarButton_1.trailingAnchor.constraint(equalTo: navigationBar.centerXAnchor, constant: -16),
            navigationBarButton_1.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            navigationBarButton_2.leadingAnchor.constraint(equalTo: navigationBar.centerXAnchor, constant: 16),
            navigationBarButton_2.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16),
            navigationBarButton_2.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        layout()
        self.navigationBarButton_1.addTarget(self, action: #selector(createAfolder), for: .touchUpInside)
        self.navigationBarButton_2.addTarget(self, action: #selector(addAphoto), for: .touchUpInside)
        self.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "circle"), tag: 0)

    }

    @objc
    func createAfolder() {

        let alert = UIAlertController(title: "Создать папку", message: "Введите название папки", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { action in
            let newDirectoryPath = self.path + "/" + (alert.textFields?[0].text)!.uppercased()
            try? FileManager.default.createDirectory(atPath: newDirectoryPath, withIntermediateDirectories: false)
            self.tableView.reloadData()
            print("создать папку")
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
            print("отмена")
        }))
        self.present(alert, animated: true)

    }

    @objc
    func addAphoto() {
        showPicker()
    }

}

extension FirstViewController: UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        self.files.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FirstViewCell.self), for: indexPath) as! FirstViewCell
        cell.setupCell(model: self.files[indexPath.row])
        return cell

    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fullPath = self.path + "/" + self.files[indexPath.row]
            try? FileManager.default.removeItem(atPath: fullPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullPath = self.path + "/" + self.files[indexPath.row]
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir) {
            if isDir.boolValue == true {
                let tvc = FirstViewController()
                tvc.path = fullPath
                navigationController?.pushViewController(tvc, animated: true)
                navigationController?.navigationBar.isHidden = false
            } else {
                let dvc = DetailViewController()
                dvc.imageView.image = UIImage(named: fullPath)
                navigationController?.pushViewController(dvc, animated: true)
                navigationController?.navigationBar.isHidden = false
            }
        }
    }

    func showPicker() {

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        present(imagePickerController, animated: true)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
//            dismiss(animated: true)
            var imgName = imgUrl.lastPathComponent

            let alert = UIAlertController(title: "Введите название файла", message: "", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Enter text"
            }
            alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { action in
                let fileType = imgName.components(separatedBy: ".")
                imgName = (alert.textFields?[0].text)! + "." + fileType[1]
                let  urlDestination = URL(filePath: (self.path + "/" + imgName))
                try? FileManager.default.copyItem(at: imgUrl, to: urlDestination)
                self.tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "По умолчанию", style: .default, handler: { action in
                let  urlDestination = URL(filePath: (self.path + "/" + imgName))
                try? FileManager.default.copyItem(at: imgUrl, to: urlDestination)
                self.tableView.reloadData()
            }))
            dismiss(animated: true)
            present(alert, animated: true)
            //            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            //            let localPath = documentDirectory?.appending(imgName)
            //            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            //            let data = image.pngData()! as NSData
            //            data.write(toFile: localPath!, atomically: true)
            //            let imageData = NSData(contentsOfFile: localPath!)!
            //            let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)

        }

    }

}
