//
//  GHFButton.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import UIKit

class GHFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, buttonTitle: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(buttonTitle, for: .normal)
        setupButtonView()
    }
    
    private func setupButtonView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
