//
//  DashboardViewModelTests.swift
//  ElevenTenTests
//
//  Created by César Venzor on 06/04/25.
//

import XCTest
@testable import ElevenTen

final class DashboardViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitCallsFetchMethod() {
        let viewModel = MockDashboardViewModel()
        
        XCTAssertTrue(viewModel.fetchProgramsCalled, "fetchProgramsFromAPI() method not called at init")
        XCTAssertEqual(viewModel.programs.count, 0)
    }
    
    func testWhenProgramExistsReturnsCount() {
        let viewModel = MockDashboardViewModel()
        
        let mockProgram = Program(
            id: "1", programName: "RB-PROGRAM-1.0",
            duration: "1 week",
            level: "Easy",
            days: [
                Day(id: "1", dayName: "Day 1",
                    drills: [
                        Drill(id: "d1",
                              type: "warmup",
                              title: "Basic Drill",
                              description: "Desc",
                              imageUrl: nil,
                              videoUrl: nil,
                              videos: nil)
                    ])
            ]
        )
        
        viewModel.programs = [mockProgram]
        viewModel.currentProgram = mockProgram

        XCTAssertEqual(viewModel.currentProgram?.programName, "RB-PROGRAM-1.0")
        XCTAssertEqual(viewModel.getDrillsForToday().count, 1)
    }
    
    func testGetDrillsReturnsEmptyIfNoData() {
        let viewModel = MockDashboardViewModel()
        
        let drills = viewModel.getDrillsForToday()
        
        XCTAssertEqual(drills.count, 0)
    }
}

class MockDashboardViewModel: DashboardViewModel {
    var fetchProgramsCalled = false

    override func fetchProgramsFromAPI() {
        fetchProgramsCalled = true
    }
}
