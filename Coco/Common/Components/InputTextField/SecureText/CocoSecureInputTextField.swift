//
//  CocoSecureInputTextField.swift
//  Coco
//
//  Created by Jackie Leonardy on 16/07/25.
//

import Foundation
import SwiftUI

private let kInputHeight: CGFloat = 52.0

struct CocoSecureInputTextField: View {
    @ObservedObject var viewModel: CocoSecureInputTextFieldViewModel
    @State private var isSecure: Bool = true
    
    @State private var internalFocus: Bool = false
    @FocusState private var isFocused: Bool
    private let onFocusedAction: ((Bool) -> Void)?
    
    init(
        viewModel: CocoSecureInputTextFieldViewModel,
        onFocusedAction: ((Bool) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.onFocusedAction = onFocusedAction
    }
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(
                    viewModel.placeholderText,
                    text: $viewModel.currentTypedText
                )
            }
            else {
                TextField(
                    viewModel.placeholderText,
                    text: $viewModel.currentTypedText
                )
                .autocorrectionDisabled()
            }
        }
        .textFieldStyle(
            CocoSecureInputTextFieldStyle(
                leadingIcon: viewModel.leadingIcon,
                isFocused: $internalFocus,
                isSecure: $isSecure,
                placeHolder: viewModel.placeholderText,
                onFocusedAction: onFocusedAction
            )
        )
        .focused($isFocused)
        .onChange(of: isFocused) { isFocused in
            internalFocus = isFocused
            onFocusedAction?(isFocused)
        }
        .font(.jakartaSans(forTextStyle: .body, weight: .medium))
        .frame(height: kInputHeight)
    }
}

final class CocoSecureInputTextFieldHostingController: UIHostingController<CocoSecureInputTextField> {
    init(viewModel: CocoSecureInputTextFieldViewModel) {
        let view = CocoSecureInputTextField(viewModel: viewModel)
        super.init(rootView: view)
    }

    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
