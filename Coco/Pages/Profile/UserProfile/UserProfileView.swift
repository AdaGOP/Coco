//
//  UserProfileView.swift
//  Coco
//
//  Created by Jackie Leonardy on 16/07/25.
//

import Foundation
import UIKit

final class UserProfileView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addlogoutButton(with view: UIView) {
        logoutButtonContainer.subviews.forEach { $0.removeFromSuperview() }
        logoutButtonContainer.addSubviewAndLayout(view)
    }
    
    private lazy var logoutButtonContainer: UIView = UIView()
}

private extension UserProfileView {
    func setupView() {
        addSubviewAndLayout(logoutButtonContainer, insets: UIEdgeInsets(vertical: 0, horizontal: 26.0))
    }
}
