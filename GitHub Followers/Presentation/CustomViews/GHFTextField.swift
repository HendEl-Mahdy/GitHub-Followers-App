//
//  GHFTextField.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import UIKit

/// A custom text field for entering a GitHub username.
class GHFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFieldView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(AppConstants.initialError)
    }
    
    private func setupTextFieldView() {
        placeholder = AppConstants.textFieldPlaceholder
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        
        translatesAutoresizingMaskIntoConstraints = false
        autocorrectionType = .no
        adjustsFontSizeToFitWidth = true
        returnKeyType = .go
        
        layer.cornerRadius = AppConstants.textFieldCornerRadius
        layer.borderWidth = AppConstants.textFieldBorderWidth
        layer.borderColor = UIColor.systemGray3.cgColor
        backgroundColor = .tertiarySystemBackground
        tintColor = .label
        textColor = .label
        
    }
}
