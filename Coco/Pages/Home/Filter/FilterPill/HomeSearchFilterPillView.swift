//
//  HomeSearchFilterPillView.swift
//  Coco
//
//  Created by Jackie Leonardy on 09/07/25.
//

import Foundation
import SwiftUI

struct HomeSearchFilterPillView: View {
    @ObservedObject var state: HomeSearchFilterPillState
    
    var body: some View {
        Text(state.title)
            .lineLimit(1)
            .font(.jakartaSans(forTextStyle: .body, weight: .light))
            .foregroundStyle(state.isSelected ? Token.additionalColorsBlack.toColor() : Token.mainColorPrimary.toColor())
            .padding(.vertical, 8.0)
            .padding(.horizontal, 16.0)
            .background(Token.additionalColorsWhite.toColor())
            .overlay {
                RoundedRectangle(cornerRadius: 24.0)
                    .stroke(
                        state.isSelected ? Token.additionalColorsLine.toColor() : Token.mainColorPrimary.toColor(),
                        lineWidth: 1.0
                    )
            }
            .cornerRadius(24.0)
            .animation(.easeInOut(duration: 0.3), value: state.isSelected)
    }
}
