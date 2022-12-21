//
//  DetailViewController.swift
//  Documents
//
//  Created by Андрей Васильев on 21.12.2022.
//

import UIKit

class DetailViewController: UIViewController {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.toAutoLayout()
        return view
    }()

    private func layout() {

        view.addSubview(imageView)

        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        
    }

}
