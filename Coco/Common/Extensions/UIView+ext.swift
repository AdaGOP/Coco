//
//  UIView+ext.swift
//  Coco
//
//  Created by Jackie Leonardy on 03/07/25.
//

import Foundation
import UIKit

extension UIView {
    func layout(using builderBlock: (ConstraintBuilder) -> Void) {
        let builder: ConstraintBuilder = ConstraintBuilder(view: self)
        builderBlock(builder)
        builder.activate()
    }
    
    func addSubviewAndLayout(
        _ subview: UIView,
        insets: UIEdgeInsets = .zero
    ) {
        addSubview(subview)

        subview.layout {
            $0.top(equalTo: topAnchor, constant: insets.top)
              .leading(equalTo: leadingAnchor, constant: insets.left)
              .trailing(equalTo: trailingAnchor, constant: -insets.right)
              .bottom(equalTo: bottomAnchor, constant: -insets.bottom)
        }
    }
}
