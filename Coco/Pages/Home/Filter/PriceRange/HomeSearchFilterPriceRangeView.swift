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
            HStack {
                Text("Min: $\(Int(model.minPrice))")
                Spacer()
                Text("Max: $\(Int(model.maxPrice))")
            }
            .font(.caption)
            .padding(.horizontal)

            GeometryReader { geo in
                let width = geo.size.width
                let lowerRatio = CGFloat((model.minPrice - model.range.lowerBound) / (model.range.upperBound - model.range.lowerBound))
                let upperRatio = CGFloat((model.maxPrice - model.range.lowerBound) / (model.range.upperBound - model.range.lowerBound))

                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 6)

                    Capsule()
                        .fill(Color.blue)
                        .frame(
                            width: (upperRatio - lowerRatio) * width,
                            height: 6
                        )
                        .offset(x: lowerRatio * width)

                    // Min thumb
                    Circle()
                        .fill(Color.white)
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .frame(width: 28, height: 28)
                        .offset(x: lowerRatio * width - 14)
                        .gesture(DragGesture().onChanged { value in
                            let percent = min(max(0, value.location.x / width), upperRatio)
                            let newValue = model.range.lowerBound + Double(percent) * (model.range.upperBound - model.range.lowerBound)
                            model.minPrice = min(max(model.range.lowerBound, round(newValue / model.step) * model.step), model.maxPrice - model.step)
                        })

                    // Max thumb
                    Circle()
                        .fill(Color.white)
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .frame(width: 28, height: 28)
                        .offset(x: upperRatio * width - 14)
                        .gesture(DragGesture().onChanged { value in
                            let percent = max(min(1, value.location.x / width), lowerRatio)
                            let newValue = model.range.lowerBound + Double(percent) * (model.range.upperBound - model.range.lowerBound)
                            model.maxPrice = max(min(model.range.upperBound, round(newValue / model.step) * model.step), model.minPrice + model.step)
                        })
                }
                .frame(height: 44)
            }
            .frame(height: 44)
        }
        .padding()
    }
}
