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

    func testLoadProgramsFromMockJSON() {
        let mockJSON = """
        {
            "programs": [
                {
                    "programName": "RB-PROGRAM-1.0",
                    "duration": "2 Semanas",
                    "level": "Principiantes",
                    "days": [
                        {
                            "id": "1",
                            "dayName": "Día 1: Derecha",
                            "drills": [
                                {
                                    "id": "1",
                                    "type": "lista_videos",
                                    "title": "A: Control",
                                    "description": "",
                                    "imageUrl": null,
                                    "videoUrl": null,
                                    "videos": []
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        """
        let jsonData = mockJSON.data(using: .utf8)
        
        let viewModel = DashboardViewModel(jsonData: jsonData)
        
        XCTAssertEqual(viewModel.programs.count, 1)
        XCTAssertEqual(viewModel.currentProgram?.programName, "RB-PROGRAM-1.0")
        
        XCTAssertEqual(viewModel.getDrillsForToday().count, 1)
        XCTAssertEqual(viewModel.getDrillsForToday().first?.title, "A: Control")
    }
    
    func testGetDrillsReturnsEmptyIfNoData() {
        let viewModel = DashboardViewModel(jsonData: Data())
        
        let drills = viewModel.getDrillsForToday()
        
        XCTAssertEqual(drills.count, 0)
    }
}
