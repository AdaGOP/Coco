//
//  UIFont+ext.swift
//  Coco
//
//  Created by Jackie Leonardy on 03/07/25.
//

import Foundation
import UIKit

extension UIFont {
    static func jakartaSans(
        forTextStyle style: UIFont.TextStyle,
        weight: UIFont.Weight = .regular
    ) -> UIFont {
        let fontName: String = "PlusJakartaSans-Regular"

        guard let customFont: UIFont = UIFont(name: fontName, size: UIFont.preferredFont(forTextStyle: style).pointSize) else {
            assertionFailure("Failed to load custom font: \(fontName)")
            return UIFont.preferredFont(forTextStyle: style)
        }

        return UIFontMetrics(forTextStyle: style).scaledFont(for: customFont)
    }
}
