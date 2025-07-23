//
//  HomeFormScheduleViewController.swift
//  Coco
//
//  Created by Jackie Leonardy on 12/07/25.
//

import Foundation
import UIKit


import SwiftUI

struct HomeFormScheduleViewss: View {
    @ObservedObject var calendarViewModel: HomeSearchBarViewModel
    @ObservedObject var paxInputViewModel: HomeSearchBarViewModel
    
    var actionButtonAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Date Visit")
                    .font(.jakartaSans(forTextStyle: .footnote, weight: .medium))
                    .foregroundStyle(Token.grayscale70.toColor())
                
                HomeSearchBarView(viewModel: calendarViewModel)
            }
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Number of People")
                    .font(.jakartaSans(forTextStyle: .footnote, weight: .medium))
                    .foregroundStyle(Token.grayscale70.toColor())
                HomeSearchBarView(viewModel: paxInputViewModel)
            }
            
            Spacer()
            
            CocoButton(
                action: actionButtonAction,
                text: "Checkout",
                style: .large,
                type: .primary
            )
            .stretch()
        }
    }
}

final class HomeFormScheduleViewController: UIViewController {
    init(viewModel: HomeFormScheduleViewModelProtocol) {
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
        title = "Form Schedule"
    }
    
    private let viewModel: HomeFormScheduleViewModelProtocol
    private let thisView: HomeFormScheduleView = HomeFormScheduleView()
}

extension HomeFormScheduleViewController: HomeFormScheduleViewModelAction {
    func setupView(
        calendarViewModel: HomeSearchBarViewModel,
        paxInputViewModel: HomeSearchBarViewModel
    ) {
        let inputVC: UIHostingController = UIHostingController(
            rootView: HomeFormScheduleViewss(
                calendarViewModel: calendarViewModel,
                paxInputViewModel: paxInputViewModel,
                actionButtonAction: { [weak self] in
                    self?.viewModel.onCheckout()
                }
            )
        )
        addChild(inputVC)
        thisView.addInputView(from: inputVC.view)
        inputVC.didMove(toParent: self)
    }
    
    func configureView(data: HomeFormScheduleViewData) {
        thisView.configureView(data: data)
    }
    
    func showCalendarOption() {
        let calendarVC: CocoCalendarViewController = CocoCalendarViewController()
        calendarVC.delegate = self
        let popup: CocoPopupViewController = CocoPopupViewController(child: calendarVC)
        present(popup, animated: true)
    }
}

extension HomeFormScheduleViewController: CocoCalendarViewControllerDelegate {
    func notifyCalendarDidChooseDate(date: Date?, calendar: CocoCalendarViewController) {
        guard let date: Date else { return }
        viewModel.onCalendarDidChoose(date: date)
    }
}
