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
}
