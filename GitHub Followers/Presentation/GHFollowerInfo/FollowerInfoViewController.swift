//
//  FollowerInfoViewController.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 11/02/2025.
//

import UIKit

class FollowerInfoViewController: UIViewController {
    
    var followerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }


}
