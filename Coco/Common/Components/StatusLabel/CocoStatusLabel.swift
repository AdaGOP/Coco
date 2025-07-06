//
//  CocoStatusLabel.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation
import SwiftUI

struct CocoStatusLabel: View {
    let title: String
    let style: CocoStatusLabelStyle
    
    var body: some View {
        Text(title)
            .font(.jakartaSans(forTextStyle: .body, weight: .light))
            .foregroundStyle(style.textColor.toColor())
            .padding(.vertical, 4.0)
            .padding(.horizontal, 16.0)
            .background(style.backgroundColor.toColor())
            .cornerRadius(4.0)
    }
}
