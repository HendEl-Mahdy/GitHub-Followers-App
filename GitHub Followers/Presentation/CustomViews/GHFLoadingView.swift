//
//  GHFLoadingView.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 14/02/2025.
//

import UIKit
import SnapKit

class GHFLoadingView: UIView {
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        alpha = 0
        setupLoadingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoadingView() {
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func showLoading() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 0.6
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.alpha = 0
            self.activityIndicator.stopAnimating()
//            self.removeFromSuperview()
        }
    }
}
