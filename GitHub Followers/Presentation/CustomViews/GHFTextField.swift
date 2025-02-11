//
//  GHFTextField.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import UIKit

class GHFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFieldView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextFieldView() {
        placeholder = "Username"
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        
        translatesAutoresizingMaskIntoConstraints = false
        autocorrectionType = .no
        adjustsFontSizeToFitWidth = true
        returnKeyType = .go
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray3.cgColor
        backgroundColor = .tertiarySystemBackground
        tintColor = .label
        textColor = .label
        
    }
}
