//
//  HomeSearchFilterPriceRangeView.swift
//  Coco
//
//  Created by Jackie Leonardy on 09/07/25.
//

import Foundation
import SwiftUI

struct HomeSearchFilterPriceRangeView: View {
    @ObservedObject var model: HomeSearchFilterPriceRangeModel

    var body: some View {
        VStack {
            // Labels
            HStack {
                Text("Min: $\(Int(model.minPrice))")
                Spacer()
                Text("Max: $\(Int(model.maxPrice))")
            }
            .padding(.horizontal)

            GeometryReader { geo in
                ZStack {
                    // Background track
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 6)

                    // Selected range
                    Capsule()
                        .fill(Color.blue)
                        .frame(
                            width: CGFloat((model.maxPrice - model.minPrice) / (model.range.upperBound - model.range.lowerBound)) * geo.size.width,
                            height: 6
                        )
                        .offset(x: CGFloat((model.minPrice - model.range.lowerBound) / (model.range.upperBound - model.range.lowerBound)) * geo.size.width)

                    // Min knob
                    Circle()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.white)
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .offset(x: CGFloat((model.minPrice - model.range.lowerBound) / (model.range.upperBound - model.range.lowerBound)) * geo.size.width - 14)
                        .gesture(DragGesture().onChanged { value in
                            let percent = max(0, min(1, value.location.x / geo.size.width))
                            let newValue = model.range.lowerBound + percent * (model.range.upperBound - model.range.lowerBound)
                            model.minPrice = min(max(model.range.lowerBound, newValue.rounded()), model.maxPrice - model.step)
                        })

                    // Max knob
                    Circle()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.white)
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .offset(x: CGFloat((model.maxPrice - model.range.lowerBound) / (model.range.upperBound - model.range.lowerBound)) * geo.size.width - 14)
                        .gesture(DragGesture().onChanged { value in
                            let percent = max(0, min(1, value.location.x / geo.size.width))
                            let newValue = model.range.lowerBound + percent * (model.range.upperBound - model.range.lowerBound)
                            model.maxPrice = max(min(model.range.upperBound, newValue.rounded()), model.minPrice + model.step)
                        })
                }
                .frame(height: 44)
            }
            .frame(height: 44)
        }
        .padding()
    }
}
