//
//  HomeSearchBarView.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation
import SwiftUI

struct HomeSearchBarView: View {
    @ObservedObject var viewModel: HomeSearchBarViewModel
    
    var body: some View {
        CocoInputTextField(
            leadingIcon: CocoIcon.icSearchLoop.image,
            currentTypedText: $viewModel.currentTypedText,
            trailingIcon: viewModel.trailingIcon,
            placeholder: "Search...",
            shouldInterceptFocus: !viewModel.isTypeAble,
            onFocusedAction: viewModel.onTextFieldFocusDidChange(to:)
        )
    }
}

