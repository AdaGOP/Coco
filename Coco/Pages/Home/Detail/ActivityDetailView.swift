//
//  ActivityDetailView.swift
//  Coco
//
//  Created by Jackie Leonardy on 06/07/25.
//

import Foundation
import UIKit

final class ActivityDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(_ data: ActivityDetailDataModel) {
        titleLabel.text = data.title
        locationLabel.text = data.location
        
        // Detail section
        let detailDescription: UILabel = UILabel(
            font: .jakartaSans(forTextStyle: .headline, weight: .regular),
            textColor: Token.grayscale70,
            numberOfLines: 0
        )
        detailDescription.text = data.detailInfomation.content
        contentStackView.addArrangedSubview(
            createSectionView(
                title: data.detailInfomation.title,
                view: detailDescription
            )
        )
        
        // Trip Provider
        let sectionLabel: UILabel = UILabel(
            font: .jakartaSans(forTextStyle: .title3, weight: .regular),
            textColor: Token.grayscale70,
            numberOfLines: 0
        )
        sectionLabel.text = data.detailInfomation.content
        contentStackView.addArrangedSubview(
            createSectionView(
                title: data.providerDetail.title,
                view: UIView()
            )
        )
        
        // Facilities
        contentStackView.addArrangedSubview(
            createSectionView(
                title: data.tripFacilities.title,
                view: createBenefitListView(titles: data.tripFacilities.content)
            )
        )
        
        // TnC
        contentStackView.addArrangedSubview(
            createSectionView(
                title: data.tnc.title,
                view: createBenefitListView(titles: data.tnc.content)
            )
        )
    }
    
    func addImageSliderView(with view: UIView) {
        imageSliderView.subviews.forEach { $0.removeFromSuperview() }
        imageSliderView.addSubviewAndLayout(view)
    }
    
    func updatePackageData(_ data: [ActivityDetailDataModel.Package]) {
        
    }
    
    private lazy var imageSliderView: UIView = UIView()
    private lazy var titleView: UIView = createTitleView()
    private lazy var titleLabel: UILabel = UILabel(
        font: .jakartaSans(forTextStyle: .title1, weight: .bold),
        textColor: Token.additionalColorsBlack,
        numberOfLines: 2
    )
    
    private lazy var locationLabel: UILabel = UILabel(
        font: .jakartaSans(forTextStyle: .footnote, weight: .medium),
        textColor: Token.grayscale90,
        numberOfLines: 2
    )
    
    private lazy var contentStackView: UIStackView = createStackView(spacing: 29.0)
    private lazy var headerStackView: UIStackView = createStackView(spacing: 0)
}

extension ActivityDetailView {
    func setupView() {
        let scrollView: UIScrollView = UIScrollView()
        let contentView: UIView = UIView()
        
        scrollView.addSubviewAndLayout(contentView)
        contentView.layout {
            $0.widthAnchor(to: scrollView.widthAnchor)
        }
        
        addSubviewAndLayout(scrollView)
        
        contentView.addSubviews([
            headerStackView,
            contentStackView
        ])
        
        headerStackView.backgroundColor = UIColor.from("#F5F5F5")
        headerStackView.addArrangedSubview(imageSliderView)
        headerStackView.addArrangedSubview(titleView)
        
        headerStackView.layout {
            $0.top(to: contentView.topAnchor)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
        }
        
        contentStackView.layout {
            $0.top(to: headerStackView.bottomAnchor, constant: -8.0)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
                .bottom(to: contentView.bottomAnchor)
        }
        
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = .init(vertical: 20.0, horizontal: 15.0)
        contentStackView.layer.cornerRadius = 24.0
        contentStackView.backgroundColor = Token.additionalColorsWhite
        
        scrollView.backgroundColor = UIColor.from("#F5F5F5")
    }
}

private extension ActivityDetailView {
    func createStackView(
        spacing: CGFloat,
        axis: NSLayoutConstraint.Axis = .vertical
    ) -> UIStackView {
        let stackView: UIStackView = UIStackView()
        stackView.spacing = spacing
        stackView.axis = axis
        
        return stackView
    }
    
    func createSectionView(title: String, view: UIView) -> UIView {
        let contentView: UIView = UIView()
        let titleLabel: UILabel = UILabel(
            font: .jakartaSans(forTextStyle: .subheadline, weight: .bold),
            textColor: Token.additionalColorsBlack,
            numberOfLines: 2
        )
        titleLabel.text = title
        
        contentView.addSubviews([
            titleLabel,
            view
        ])
        
        titleLabel.layout {
            $0.top(to: contentView.topAnchor)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
        }
        
        view.layout {
            $0.top(to: titleLabel.bottomAnchor, constant: 8.0)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
                .bottom(to: contentView.bottomAnchor)
        }
        
        return contentView
    }
    
    func createTitleView() -> UIView {
        let pinPointImage: UIImageView = UIImageView(image: CocoIcon.icPinPointBlue.image)
        pinPointImage.layout {
            $0.size(20.0)
        }
        
        let locationView: UIView = UIView()
        locationView.addSubviews([
            pinPointImage,
            locationLabel
        ])
        
        pinPointImage.layout {
            $0.leading(to: locationView.leadingAnchor)
                .bottom(to: locationView.bottomAnchor)
                .top(to: locationView.topAnchor)
        }
        
        locationLabel.layout {
            $0.leading(to: pinPointImage.trailingAnchor, constant: 4.0)
                .trailing(to: locationView.trailingAnchor)
                .centerY(to: locationView.centerYAnchor)
        }
        
        let contentView: UIView = UIView()
        contentView.addSubviews([
            titleLabel,
            locationView
        ])
        
        titleLabel.layout {
            $0.leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
                .top(to: contentView.topAnchor)
        }
        
        locationView.layout {
            $0.top(to: titleLabel.bottomAnchor, constant: 8.0)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
                .bottom(to: contentView.bottomAnchor)
        }
        
        let contentWrapperView: UIView = UIView()
        contentWrapperView.addSubviewAndLayout(
            contentView,
            insets: .init(
                top: 16.0,
                left: 24.0,
                bottom: 16.0 + 8.0,
                right: 16.0
            )
        )
        
        return contentWrapperView
    }
    
    func createBenefitView(title: String) -> UIView {
        let contentView: UIView = UIView()
        let benefitImageView: UIImageView = UIImageView(image: CocoIcon.icCheckMarkFill.image)
        benefitImageView.layout {
            $0.size(24.0)
        }
        let benefitLabel: UILabel = UILabel(
            font: .jakartaSans(forTextStyle: .callout, weight: .regular),
            textColor: Token.additionalColorsBlack,
            numberOfLines: 0
        )
        benefitLabel.text = title
        
        contentView.addSubviews([
            benefitImageView,
            benefitLabel
        ])
        
        benefitImageView.layout {
            $0.top(to: contentView.topAnchor)
                .leading(to: contentView.leadingAnchor)
                .bottom(to: contentView.bottomAnchor, relation: .lessThanOrEqual)
        }
        
        benefitLabel.layout {
            $0.leading(to: benefitImageView.trailingAnchor, constant: 4.0)
                .top(to: contentView.topAnchor)
                .bottom(to: contentView.bottomAnchor)
                .trailing(to: contentView.trailingAnchor)
        }
        
        return contentView
    }
    
    func createBenefitListView(titles: [String]) -> UIView {
        let stackView: UIStackView = createStackView(spacing: 12.0)
        
        titles.forEach { title in
            stackView.addArrangedSubview(createBenefitView(title: title))
        }
        
        return stackView
    }
}
