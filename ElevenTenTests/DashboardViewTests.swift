//
//  DashboardViewTests.swift
//  ElevenTenTests
//
//  Created by César Venzor on 06/04/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ElevenTen

final class DashboardViewTests: XCTestCase {
    func testWelcomeTextExists() throws {
        let view = DashboardView(viewModel: MockDashboardViewModel())
        
        let navigationStack = try view.inspect().find(ViewType.NavigationStack.self)
        
        let text = try navigationStack.scrollView(0).vStack().text(0)
        
        XCTAssertEqual(try text.string(), "Welcome 👋")
    }

    @MainActor func testDashboardShowsContinueWhenCurrentProgramExists() async throws {
        let mockProgram = Program(
            id: "1", programName: "Beginner",
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
        
        let viewModel = MockDashboardViewModel()
        viewModel.programs = [mockProgram]
        viewModel.currentProgram = mockProgram
        
        let sut = DashboardView(viewModel: viewModel)
        
        let navigationStack = try sut.inspect().find(ViewType.NavigationStack.self)
        
        let scrollView = try navigationStack.scrollView()
        let vStack = try scrollView.vStack()
        
        let programsText = try vStack.find(text: "Continue Program")
        XCTAssertEqual(try programsText.string(), "Continue Program")
    }

}
