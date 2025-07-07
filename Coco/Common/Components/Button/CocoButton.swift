//
//  CocoButton.swift
//  Coco
//
//  Created by Jackie Leonardy on 07/07/25.
//

import Foundation
import SwiftUI

struct CocoButton: View {
    @Environment(\.isStretch) var isStretch: Bool
    
    private let action: () -> Void
    private let text: String
    
    private let style: CocoButtonStyle
    private let type: CocoButtonType
    
    init(
        action: @escaping () -> Void,
        text: String,
        style: CocoButtonStyle,
        type: CocoButtonType
    ) {
        self.action = action
        self.text = text
        self.style = style
        self.type = type
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.jakartaSans(forTextStyle: .body, weight: .semibold))
                .frame(maxWidth: isStretch ? .infinity : nil)
        }
        .disabled(type == .disabled)
        .buttonStyle(CocoButtonStyleConfiguration(style: style, type: type))
    }
}

struct CocoButtonStyleConfiguration: ButtonStyle {
    init(style: CocoButtonStyle, type: CocoButtonType) {
        self.style = style
        self.type = type
    }
    
    private let style: CocoButtonStyle
    private let type: CocoButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(style.padding)
            .frame(height: style.height)
            .foregroundColor(type.textColor)
            .background(type.backgroundColor)
            .cornerRadius(style.cornerRadius)
    }
}
