//
//  ActivityDetailViewController.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation
import UIKit

final class ActivityDetailViewController: UIViewController {
    init(viewModel: ActivityDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.actionDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = thisView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
    }
    
    private let viewModel: ActivityDetailViewModelProtocol
    private let thisView: ActivityDetailView = ActivityDetailView()
}

extension ActivityDetailViewController: ActivityDetailViewModelAction {
    func configureView(data: ActivityDetailDataModel) {
        thisView.configureView(data)
        
        let sliderVCs: ImageSliderHostingController = ImageSliderHostingController(
            images: [
                "https://picsum.photos/id/237/600/341",
                "https://picsum.photos/id/238/600/341",
                "https://picsum.photos/id/239/600/341"
            ]
        )
        addChild(sliderVCs)
        thisView.addImageSliderView(with: sliderVCs.view)
        sliderVCs.didMove(toParent: self)
    }
    
    func updatePackageData(data: [ActivityDetailDataModel.Package]) {
        thisView.updatePackageData(data)
    }
}
