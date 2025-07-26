//
//  HomeViewModelTest.swift
//  CocoTests
//
//  Created by Jackie Leonardy on 26/07/25.
//

import Foundation
import Testing
@testable import Coco

struct HomeViewModelTest {

    @Test("open the filter tray")
    func tapping_search_bar_trailing_icon() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        // --- WHEN ---
        viewModel.onViewDidLoad()
        viewModel.searchBarViewModel.trailingIcon?.didTap?()
        
        // --- THEN ---
        #expect(actionDelegateMock.invokedOpenFilterTrayCount == 1)
    }
    
    @Test("filtering from the filter tray")
    func filter_tray_did_apply() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        // --- WHEN ---
        viewModel.onViewDidLoad()
        viewModel.searchBarViewModel.trailingIcon?.didTap?()
        actionDelegateMock.invokedOpenFilterTrayParameters?.viewModel.filterDidApplyPublisher.send(
            HomeSearchFilterTrayDataModel(
                filterPillDataState: [],
                priceRangeModel: HomeSearchFilterPriceRangeModel(minPrice: 499000.0, maxPrice: 200000, range: 0...0)
            )
        )
        
        // --- THEN ---
        #expect(actionDelegateMock.invokedOpenFilterTrayCount == 1)
        #expect(viewModel.collectionViewModel.activityData.dataModel.count == 1)
        
    }
    
    @Test("success when view did load")
    func success_on_view_first_load() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        
        // --- WHEN ---
        #expect(viewModel.loadingState.percentage == 0)
        viewModel.onViewDidLoad()
        
        // --- THEN ---
        #expect(actionDelegateMock.invokedConstructCollectionViewCount == 1)
        #expect(actionDelegateMock.invokedConstructLoadingStateCount == 1)
        #expect(actionDelegateMock.invokedConstructNavBarCount == 1)
        
        #expect(viewModel.loadingState.percentage == 100)
        #expect(actionDelegateMock.invokedToggleLoadingViewCount == 1)
        #expect(actionDelegateMock.invokedToggleLoadingViewParameters?.isShown == false)
        #expect(actionDelegateMock.invokedToggleLoadingViewParameters?.after == 1.0)
        
        #expect(viewModel.collectionViewModel.activityData == ("", [
            HomeActivityCellDataModel(activity: activities.values[0])
        ]))
    }
    
    @Test("applying search query")
    func query_search_applied() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        // --- WHEN ---
        #expect(viewModel.loadingState.percentage == 0)
        viewModel.onViewDidLoad()
        
        let activitiesEmpty: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities-empty")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activitiesEmpty), ())
        
        viewModel.onSearchDidApply("")
        
        // --- THEN ---
        #expect(viewModel.searchBarViewModel.currentTypedText == "")
        #expect(viewModel.loadingState.percentage == 100)
        #expect(actionDelegateMock.invokedToggleLoadingViewParametersList.map { $0.isShown } == [false, true, false] )
        
        #expect(viewModel.collectionViewModel.activityData == ("", []))
    }
    
    @Test("success with known data id activity from collection view did tap")
    func success_tap_activity_collection_view_data() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        
        // --- WHEN ---
        viewModel.onViewDidLoad()
        viewModel.notifyCollectionViewActivityDidTap(
            HomeActivityCellDataModel(
                id: 1,
                area: "area",
                name: "name",
                priceText: "priceText",
                imageUrl: nil
            )
        )
        
        // --- THEN ---
        #expect(actionDelegateMock.invokedActivityDidSelectCount == 1)
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data == ActivityDetailDataModel(activities.values[0]))
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.title == "Snorkeling Adventure in Nusa Penida")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.location == "Nusa Penida")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.imageUrlsString == ["https://example.com/images/nusa-penida-thumb.jpg", "https://example.com/images/nusa-penida-gallery1.jpg"])
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.detailInfomation.title == "Details")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.detailInfomation.content == "Explore the stunning underwater world of Nusa Penida with our professional guides. Perfect for beginners and experienced snorkelers alike.")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.providerDetail.title == "Trip Provider")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.providerDetail.content.name == "Made Wirawan")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.providerDetail.content.imageUrlString == "https://example.com/hosts/made-wirawan.jpg")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.providerDetail.content.description == "Professional diving instructor with 5 years of experience")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.tripFacilities.title == "This Trip Includes")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.tripFacilities.content == ["Snorkeling Equipment", "Life Jacket", "Waterproof Camera"])
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.availablePackages.title == "Available Packages")
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.availablePackages.content.count == 2)
        #expect(actionDelegateMock.invokedActivityDidSelectParameters?.data.hiddenPackages.count == actionDelegateMock.invokedActivityDidSelectParameters?.data.availablePackages.content.count)
    }
    
    @Test("failed with unknown data id activity from collection view did tap")
    func failed_tap_activity_collection_view_data() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        // --- WHEN ---
        viewModel.onViewDidLoad()
        viewModel.notifyCollectionViewActivityDidTap(
            HomeActivityCellDataModel(
                id: 999,
                area: "area",
                name: "name",
                priceText: "priceText",
                imageUrl: nil
            )
        )
        
        // --- THEN ---
        #expect(actionDelegateMock.invokedActivityDidSelectCount == 0)
    }
    
    @Test("search bar being tapped from a typeable param")
    func search_bar_tapped_with_typeable() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        // --- WHEN ---
        viewModel.notifyHomeSearchBarDidTap(
            isTypeAble: true,
            viewModel: HomeSearchBarViewModel(
                leadingIcon: nil,
                placeholderText: "",
                currentTypedText: "",
                trailingIcon: nil,
                isTypeAble: true,
                delegate: nil
            )
        )
        
        // --- THEN ---
        #expect(actionDelegateMock.invokedOpenSearchTrayCount == 0)
    }
    
    @Test("search bar being tapped from a non typeable param")
    func search_bar_tapped_with_non_typeable() async throws {
        // --- GIVEN ---
        let fetcher: MockActivityFetcher = MockActivityFetcher()
        let actionDelegateMock: MockHomeViewModelAction = MockHomeViewModelAction()
        let navigationDelegateMock: MockHomeViewModelNavigationDelegate = MockHomeViewModelNavigationDelegate()
        
        let activities: ActivityModelArray = try JSONReader.getObjectFromJSON(with: "activities")
        fetcher.stubbedFetchActivityCompletionResult = (.success(activities), ())
        
        let viewModel: HomeViewModel = HomeViewModel(activityFetcher: fetcher)
        viewModel.actionDelegate = actionDelegateMock
        viewModel.navigationDelegate = navigationDelegateMock
        
        // --- WHEN ---
        viewModel.notifyHomeSearchBarDidTap(
            isTypeAble: false,
            viewModel: HomeSearchBarViewModel(
                leadingIcon: nil,
                placeholderText: "",
                currentTypedText: "",
                trailingIcon: nil,
                isTypeAble: false,
                delegate: nil
            )
        )
        
        // --- THEN ---
        #expect(actionDelegateMock.invokedOpenSearchTrayCount == 1)
    }
}

private final class MockHomeViewModelAction: HomeViewModelAction {

    var invokedConstructCollectionView = false
    var invokedConstructCollectionViewCount = 0

    func constructCollectionView(viewModel: some HomeCollectionViewModelProtocol) {
        invokedConstructCollectionView = true
        invokedConstructCollectionViewCount += 1
    }

    var invokedConstructLoadingState = false
    var invokedConstructLoadingStateCount = 0
    var invokedConstructLoadingStateParameters: (state: HomeLoadingState, Void)?
    var invokedConstructLoadingStateParametersList = [(state: HomeLoadingState, Void)]()

    func constructLoadingState(state: HomeLoadingState) {
        invokedConstructLoadingState = true
        invokedConstructLoadingStateCount += 1
        invokedConstructLoadingStateParameters = (state, ())
        invokedConstructLoadingStateParametersList.append((state, ()))
    }

    var invokedConstructNavBar = false
    var invokedConstructNavBarCount = 0
    var invokedConstructNavBarParameters: (viewModel: HomeSearchBarViewModel, Void)?
    var invokedConstructNavBarParametersList = [(viewModel: HomeSearchBarViewModel, Void)]()

    func constructNavBar(viewModel: HomeSearchBarViewModel) {
        invokedConstructNavBar = true
        invokedConstructNavBarCount += 1
        invokedConstructNavBarParameters = (viewModel, ())
        invokedConstructNavBarParametersList.append((viewModel, ()))
    }

    var invokedToggleLoadingView = false
    var invokedToggleLoadingViewCount = 0
    var invokedToggleLoadingViewParameters: (isShown: Bool, after: CGFloat)?
    var invokedToggleLoadingViewParametersList = [(isShown: Bool, after: CGFloat)]()

    func toggleLoadingView(isShown: Bool, after: CGFloat) {
        invokedToggleLoadingView = true
        invokedToggleLoadingViewCount += 1
        invokedToggleLoadingViewParameters = (isShown, after)
        invokedToggleLoadingViewParametersList.append((isShown, after))
    }

    var invokedActivityDidSelect = false
    var invokedActivityDidSelectCount = 0
    var invokedActivityDidSelectParameters: (data: ActivityDetailDataModel, Void)?
    var invokedActivityDidSelectParametersList = [(data: ActivityDetailDataModel, Void)]()

    func activityDidSelect(data: ActivityDetailDataModel) {
        invokedActivityDidSelect = true
        invokedActivityDidSelectCount += 1
        invokedActivityDidSelectParameters = (data, ())
        invokedActivityDidSelectParametersList.append((data, ()))
    }

    var invokedOpenSearchTray = false
    var invokedOpenSearchTrayCount = 0
    var invokedOpenSearchTrayParameters: (selectedQuery: String, latestSearches: [HomeSearchSearchLocationData])?
    var invokedOpenSearchTrayParametersList = [(selectedQuery: String, latestSearches: [HomeSearchSearchLocationData])]()

    func openSearchTray(
        selectedQuery: String,
        latestSearches: [HomeSearchSearchLocationData]
    ) {
        invokedOpenSearchTray = true
        invokedOpenSearchTrayCount += 1
        invokedOpenSearchTrayParameters = (selectedQuery, latestSearches)
        invokedOpenSearchTrayParametersList.append((selectedQuery, latestSearches))
    }

    var invokedOpenFilterTray = false
    var invokedOpenFilterTrayCount = 0
    var invokedOpenFilterTrayParameters: (viewModel: HomeSearchFilterTrayViewModel, Void)?
    var invokedOpenFilterTrayParametersList = [(viewModel: HomeSearchFilterTrayViewModel, Void)]()

    func openFilterTray(_ viewModel: HomeSearchFilterTrayViewModel) {
        invokedOpenFilterTray = true
        invokedOpenFilterTrayCount += 1
        invokedOpenFilterTrayParameters = (viewModel, ())
        invokedOpenFilterTrayParametersList.append((viewModel, ()))
    }

    var invokedDismissTray = false
    var invokedDismissTrayCount = 0

    func dismissTray() {
        invokedDismissTray = true
        invokedDismissTrayCount += 1
    }
}

private final class MockHomeViewModelNavigationDelegate: HomeViewModelNavigationDelegate {

    var invokedNotifyHomeDidSelectActivity = false
    var invokedNotifyHomeDidSelectActivityCount = 0

    func notifyHomeDidSelectActivity() {
        invokedNotifyHomeDidSelectActivity = true
        invokedNotifyHomeDidSelectActivityCount += 1
    }
}
