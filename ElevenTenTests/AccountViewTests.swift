//
//  AccountViewTests.swift
//  ElevenTenTests
//
//  Created by César Venzor on 05/04/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ElevenTen

final class AccountViewTests: XCTestCase {
    
    @MainActor func testFetchSubscriptionsMethodCalledAtInit() async throws {
        let mockStore = MockStore(active: false)
        let view = AccountView(store: mockStore)
        
        try await view.inspect().find(ViewType.NavigationView.self).callTask()

        XCTAssertTrue(mockStore.fetchSubscriptionsCalled, "fetchSubscribtion() method not called at .task")
    }
    
    @MainActor func testActiveSubscriptions() throws {
        let mockStore = MockStore(active: true)
        XCTAssertTrue(mockStore.hasActiveSubscription())
    }
    
    @MainActor func testProUserTextWhenSubscriptionIsActive() throws {
        let mockStore = MockStore(active: true)
        let view = AccountView(store: mockStore)
        
        let text = try view.inspect().find(ViewType.NavigationView.self).vStack().text(0).string()
        XCTAssertEqual(text, "Pro user")
    }
    
    @MainActor func testFreeUserTextWhenSubscriptionIsNotActive() throws {
        let mockStore = MockStore(active: false)
        let view = AccountView(store: mockStore)
        
        let text = try view.inspect().find(ViewType.NavigationView.self).vStack().text(0).string()
        
        XCTAssertEqual(text, "Free user")
    }
}

class MockStore: Store {
    private let active: Bool
    var fetchSubscriptionsCalled = false
    
    init(active: Bool) {
        self.active = active
        super.init()
    }
    
    override func hasActiveSubscription() -> Bool {
        return active
    }
    
    override func fetchSubscriptions() async {
        fetchSubscriptionsCalled = true
    }
}
