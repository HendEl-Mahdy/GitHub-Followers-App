//
//  UIImageView+Ext.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 11/02/2025.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String) {
        
        if let cashedImage = ImageCashe.shared.object(forKey: urlString as NSString){
            self.image = cashedImage
            return
        }
            
        guard let imageURL = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
            guard let self = self else {return}
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            ImageCashe.shared.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
