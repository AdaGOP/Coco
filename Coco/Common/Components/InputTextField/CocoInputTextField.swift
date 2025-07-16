//
//  CocoInputTextField.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation
import SwiftUI

private let kInputHeight: CGFloat = 52.0

struct CocoInputTextField: View {
    @Binding var currentTypedText: String
    
    private let shouldInterceptFocus: Bool
    private let leadingIcon: UIImage?
    private let trailingIcon: ImageHandler?
    private let placeholder: String?
    
    @State private var internalFocus: Bool = false
    @FocusState private var isFocused: Bool
    private let onFocusedAction: ((Bool) -> Void)?
    
    init(
        leadingIcon: UIImage? = nil,
        currentTypedText: Binding<String>,
        trailingIcon: ImageHandler? = nil,
        placeholder: String?,
        shouldInterceptFocus: Bool = false,
        onFocusedAction: ((Bool) -> Void)? = nil
    ) {
        self.leadingIcon = leadingIcon
        _currentTypedText = currentTypedText
        self.trailingIcon = trailingIcon
        self.placeholder = placeholder
        self.shouldInterceptFocus = shouldInterceptFocus
        self.onFocusedAction = onFocusedAction
    }
    
    var body: some View {
        TextField(
            placeholder ?? "",
            text: $currentTypedText
        )
        .textFieldStyle(
            CocoInputTextFieldStyle(
                leadingIcon: leadingIcon,
                isFocused: $internalFocus,
                placeHolder: placeholder,
                trailingIcon: trailingIcon,
                shouldInterceptFocus: shouldInterceptFocus,
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
