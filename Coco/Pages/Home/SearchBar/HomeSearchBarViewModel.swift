//
//  HomeSearchBarViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation
import SwiftUI

protocol HomeSearchBarViewModelDelegate: AnyObject {
    func notifyHomeSearchBarDidTap(isTypeAble: Bool)
}

final class HomeSearchBarViewModel: ObservableObject {
    weak var delegate: HomeSearchBarViewModelDelegate?
    
    @Published var currentTypedText: String = ""
    
    let trailingIcon: ImageHandler?
    let isTypeAble: Bool
    
    init(currentTypedText: String, trailingIcon: ImageHandler?, isTypeAble: Bool) {
        self.currentTypedText = currentTypedText
        self.trailingIcon = trailingIcon
        self.isTypeAble = isTypeAble
    }
    
    func onTextFieldFocusDidChange(to newFocus: Bool) {
        guard newFocus else { return }
        delegate?.notifyHomeSearchBarDidTap(isTypeAble: isTypeAble)
    }
}
