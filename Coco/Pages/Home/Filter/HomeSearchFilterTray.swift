//
//  HomeSearchFilterTray.swift
//  Coco
//
//  Created by Jackie Leonardy on 07/07/25.
//

import Foundation
import SwiftUI

struct HomeSearchFilterTray: View {
    @StateObject var viewModel: HomeSearchBarViewModel = HomeSearchBarViewModel(
        currentTypedText: "",
        trailingIcon: nil,
        isTypeAble: true,
        delegate: nil
    )
    
    var filterDidApply: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Search")
                .multilineTextAlignment(.center)
                .font(.jakartaSans(forTextStyle: .body, weight: .semibold))
                .foregroundStyle(Token.additionalColorsBlack.toColor())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24.0) {
                    Spacer()
                    CocoButton(
                        action: {
                            filterDidApply()
                        },
                        text: "Apply Filter",
                        style: .large,
                        type: .primary
                    )
                    .stretch()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24.0)
        .background(Color.white)
        .cornerRadius(16)
    }
}

private extension HomeSearchFilterTray {
    func createSectionView(
        title: String,
        view: (() -> some View)
    ) -> some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Text(title)
                .font(.jakartaSans(forTextStyle: .body, weight: .semibold))
                .foregroundStyle(Token.additionalColorsBlack.toColor())
            view()
        }
    }
}
