//
//  ConstraintBuilder.swift
//  Coco
//
//  Created by Jackie Leonardy on 03/07/25.
//

import Foundation
import UIKit

final class ConstraintBuilder {
    private let view: UIView
    private var constraints: [NSLayoutConstraint] = []

    init(view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    @discardableResult
    func top(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.topAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }

    @discardableResult
    func bottom(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.bottomAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }

    @discardableResult
    func leading(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.leadingAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }

    @discardableResult
    func trailing(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.trailingAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }

    @discardableResult
    func width(_ constant: CGFloat) -> Self {
        constraints.append(view.widthAnchor.constraint(equalToConstant: constant))
        return self
    }

    @discardableResult
    func height(_ constant: CGFloat) -> Self {
        constraints.append(view.heightAnchor.constraint(equalToConstant: constant))
        return self
    }

    @discardableResult
    func centerX(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.centerXAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }

    @discardableResult
    func centerY(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.centerYAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }

    func activate() {
        NSLayoutConstraint.activate(constraints)
    }
}
