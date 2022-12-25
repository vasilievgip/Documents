//
//  CustomButton.swift
//  Navigation
//
//  Created by Андрей Васильев on 30.10.2022.
//

import Foundation
import UIKit


class CustomButton: UIButton {

    var target = {}

    @objc
    private func handleButtonTap() {
        target()
    }

    convenience init(title:String?, titleColor: UIColor?, backgroundColor: UIColor?, cornerRadius: CGFloat) {
        self.init(frame: CGRect())
        if let title = title {
            setTitle(title, for: .normal)
        }
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.toAutoLayout()
    }
}
