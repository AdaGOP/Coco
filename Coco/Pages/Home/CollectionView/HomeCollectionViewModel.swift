//
//  HomeCollectionViewModel.swift
//  Coco
//
//  Created by Jackie Leonardy on 04/07/25.
//

import Foundation

final class HomeCollectionViewModel {
    weak var actionDelegate: HomeCollectionViewModelAction?
    
    func updateActivity(activity: HomeActivityCellSectionDataModel) {
        activityData = activity
        reloadCollection()
    }
    
    private var activityData: HomeActivityCellSectionDataModel = (nil, [])
}

extension HomeCollectionViewModel: HomeCollectionViewModelProtocol {
    func onViewDidLoad() {
        // Only Called Once
        actionDelegate?.configureDataSource()
    }
}

private extension HomeCollectionViewModel {
    func reloadCollection() {
        actionDelegate?.applySnapshot(createSnapshot(), completion: {
            // do nothing
        })
    }
    
    func createSnapshot() -> HomeCollectionViewSnapShot {
        var contents: [HomeCollectionContent] = []
        
        let activitySectionDataModel: HomeCollectionContent? = {
            guard !activityData.dataModel.isEmpty else {
                return nil
            }
            
            return .init(
                section: .init(
                    type: .activity,
                    title: activityData.title
                ),
                items: activityData.dataModel
            )
        }()
        
        if let activitySectionDataModel: HomeCollectionContent {
            contents.append(activitySectionDataModel)
        }
        
        var snapshot: HomeCollectionViewSnapShot = HomeCollectionViewSnapShot()
        contents.forEach { content in
            snapshot.appendSections([content.section])
            snapshot.appendItems(content.items)
        }
        
        return snapshot
    }
}
