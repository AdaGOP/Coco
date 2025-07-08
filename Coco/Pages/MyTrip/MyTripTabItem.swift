//
//  MyTripTabItem.swift
//  Coco
//
//  Created by Jackie Leonardy on 02/07/25.
//

import Foundation
import UIKit

struct MyTripTabItem: TabItemRepresentable {
    var tabTitle: String { "MyTrip" }
    var tabIcon: UIImage? { CocoIcon.icTabIconTrip.image }

    func makeRootViewController() -> UIViewController {
        let vc = MyTripViewController()
        vc.view.backgroundColor = .brown
        vc.title = "MyTrip"
        return vc
    }
}
