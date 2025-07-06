//
//  CocoInputTextFieldStyle.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation
import SwiftUI

typealias ImageHandler = (image: UIImage, didTap: (() -> Void)?)

struct CocoInputTextFieldStyle: TextFieldStyle {
    @Binding private var isFocused: Bool
    
    let leadingIcon: UIImage?
    let placeHolder: String?
    let trailingIcon: ImageHandler?
    
    init(
        leadingIcon: UIImage?,
        isFocused: Binding<Bool>,
        placeHolder: String?,
        trailingIcon: ImageHandler?
    ) {
        self.leadingIcon = leadingIcon
        _isFocused = isFocused
        self.placeHolder = placeHolder
        self.trailingIcon = trailingIcon
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(alignment: .center, spacing: 8.0) {
            if let leadingIcon: UIImage {
                Image(uiImage: leadingIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18.0, height: 18.0)
            }
            
            configuration
                
            
            Spacer()
                
            if let trailingIcon: ImageHandler {
                Rectangle()
                    .frame(width: 1.0, height: 18.0)
                    .foregroundStyle(Token.additionalColorsLine.toColor())
                
                Image(uiImage: trailingIcon.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18.0, height: 18.0)
                    .onTapGesture {
                        trailingIcon.didTap?()
                    }
            }
        }
        .padding(.vertical, 14.0)
        .padding(.horizontal, 16.0)
        .background(Token.mainColorSecondary.toColor())
        .clipShape(Capsule(style: .continuous))
    }
}
