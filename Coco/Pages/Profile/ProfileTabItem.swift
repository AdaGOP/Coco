//
//  ProfileTabItem.swift
//  Coco
//
//  Created by Jackie Leonardy on 02/07/25.
//

import Foundation
import UIKit

struct ProfileTabItem: TabItemRepresentable {
    var tabTitle: String { "Profile" }
    var tabIcon: UIImage? { CocoIcon.icTabIconProfile.image }

    func makeRootViewController() -> UIViewController {
        let vc = ProfileViewController()
        vc.view.backgroundColor = .orange
        vc.title = "Profile"
        return vc
    }
}
