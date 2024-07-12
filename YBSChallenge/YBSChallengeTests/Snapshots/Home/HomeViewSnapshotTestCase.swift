//
//  HomeViewSnapshotTestCase.swift
//  YBSChallengeTests
//
//  Created by Travis Lai on 12/7/2024.
//

import SwiftUI

@testable import YBSChallenge

final class HomeViewSnapshotTestCase: SnapshotTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_home() {
        let homeView = HomeView()
        assert(homeView)
    }
}
