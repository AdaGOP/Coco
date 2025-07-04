//
//  HomeActivityCell.swift
//  Coco
//
//  Created by Jackie Leonardy on 04/07/25.
//

import Foundation
import UIKit

final class HomeActivityCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ dataModel: HomeActivityCellDataModel) {
        imageView.loadImage(from: dataModel.imageUrl)
        areaLabel.text = dataModel.area
        nameLabel.text = dataModel.name
        
        let attributedString = NSMutableAttributedString(
            string: dataModel.priceText,
            attributes: [
                .font : UIFont.jakartaSans(forTextStyle: .body, weight: .medium),
                .foregroundColor : Token.additionalColorsBlack
            ]
        )
        
        attributedString.append(
            NSAttributedString(
                string: "/Person",
                attributes: [
                    .font : UIFont.jakartaSans(forTextStyle: .body, weight: .medium),
                    .foregroundColor : Token.additionalColorsBlack
                ]
            )
        )
        
        priceLabel.attributedText = attributedString
    }
    
    private lazy var imageView: UIImageView = createImageView()
    private lazy var areaView: UIView = createAreaView()
    private lazy var areaLabel: UILabel = UILabel(
        font: .jakartaSans(forTextStyle: .body),
        textColor: Token.additionalColorsBlack,
        numberOfLines: 2
    )
    private lazy var nameLabel: UILabel = UILabel(
        font: .jakartaSans(forTextStyle: .title1),
        textColor: Token.additionalColorsBlack,
        numberOfLines: 2
    )
    private lazy var priceLabel: UILabel = UILabel(
        font: .jakartaSans(forTextStyle: .body),
        textColor: Token.additionalColorsBlack,
        numberOfLines: 2
    )
}

private extension HomeActivityCell {
    func setupView() {
        contentView.addSubviews([
            imageView,
            areaView,
            priceLabel,
        ])
        
        imageView.layout {
            $0.top(to: contentView.topAnchor)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
        }
        
        areaView.layout {
            $0.top(to: imageView.bottomAnchor, constant: 4.0)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
        }
        
        priceLabel.layout {
            $0.top(to: areaView.bottomAnchor, constant: 4.0)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
                .bottom(to: contentView.bottomAnchor)
        }
    }
    
    func createImageView() -> UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layout {
            $0.height(238.0)
        }
        imageView.layer.cornerRadius = 12.0
        imageView.clipsToBounds = true
        return imageView
    }
    
    func createAreaView() -> UIView {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "activityAreaIcon"))
        // TODO: Add Image
        imageView.contentMode = .scaleAspectFit
        imageView.layout {
            $0.size(20)
        }
        let contentView: UIView = UIView()
        contentView.addSubviews([
            imageView,
            areaLabel
        ])
        
        imageView.layout {
            $0.leading(to: contentView.leadingAnchor)
                .top(to: contentView.topAnchor)
                .bottom(to: contentView.bottomAnchor)
        }
        
        areaLabel.layout {
            $0.leading(to: imageView.trailingAnchor, constant: 4.0)
                .centerY(to: contentView.centerYAnchor)
                .trailing(to: contentView.trailingAnchor, relation: .lessThanOrEqual)
        }
        
        return contentView
    }
}
