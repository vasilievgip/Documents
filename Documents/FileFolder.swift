//
//  Sandbox.swift
//  Navigation
//
//  Created by Андрей Васильев on 16.12.2022.
//

import Foundation

struct FileFolder {

    static let fileFolder = FileFolder()

    var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    var files : [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }

}
