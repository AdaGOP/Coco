//
//  MyTripViewController.swift
//  Coco
//
//  Created by Jackie Leonardy on 02/07/25.
//

import Foundation
import UIKit

import Foundation
import UIKit

final class MyTripViewController: UIViewController {
    init(viewModel: MyTripViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.actionDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thisView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewWillAppear()
    }
    
    override func loadView() {
        view = thisView
    }
    
    private let viewModel: MyTripViewModelProtocol
    private let thisView: MyTripView = MyTripView()
}

extension MyTripViewController: MyTripViewModelAction {
    func configureView(datas: [MyTripListCardDataModel]) {
        thisView.configureView(datas: datas)
    }
}

extension MyTripViewController: MyTripViewDelegate {
    func notifyTripListDidTap(at index: Int) {
        viewModel.onTripListDidTap(at: index)
    }
}
