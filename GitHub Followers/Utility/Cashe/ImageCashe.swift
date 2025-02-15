//
//  ImageCashe.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 11/02/2025.
//


import UIKit

class ImageCashe {
    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}
