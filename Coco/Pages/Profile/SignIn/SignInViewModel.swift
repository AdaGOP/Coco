//
//  SignInViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 15/07/25.
//

import Foundation

final class SignInViewModel {
    weak var delegate: (any SignInViewModelDelegate)?
    weak var actionDelegate: (any SignInViewModelAction)?
    
    init() { }

    private lazy var emailInputVM: HomeSearchBarViewModel = HomeSearchBarViewModel(
        leadingIcon: nil,
        placeholderText: "Enter your email address",
        currentTypedText: "",
        trailingIcon: nil,
        isTypeAble: true,
        delegate: nil
    )
    
    private lazy var passwordInputVM: HomeSearchBarViewModel = HomeSearchBarViewModel(
        isSecure: true,
        leadingIcon: nil,
        placeholderText: "Enter your password",
        currentTypedText: "",
        trailingIcon: (
            image: CocoIcon.icFilterIcon.image,
            didTap: {
                
            }
        ),
        isTypeAble: true,
        delegate: nil
    )
    
    private var tempPassword: String?
    private var isPasswordShown: Bool = false
}

extension SignInViewModel: SignInViewModelProtocol {
    func onViewDidLoad() {
        actionDelegate?.configureView(
            emailInputVM: emailInputVM,
            passwordInputVM: passwordInputVM
        )
    }
    
    func onSignInDidTap() {
        delegate?.notifySignInDidSuccess()
    }
}
