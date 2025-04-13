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
        let view = DashboardView(viewModel: DashboardViewModel())
        
        let text = try view.inspect().find(ViewType.ScrollView.self).vStack().hStack(1).text(0)
        
        XCTAssertEqual(try text.string(), "Welcome {{user}} 👋")
    }

    @MainActor func testDashboardShowsContinueWhenCurrentProgramExists() async throws {
        let mockProgram = Program(
            programName: "Beginner",
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
        
        let viewModel = DashboardViewModel()
        viewModel.programs = [mockProgram]
        viewModel.currentProgram = mockProgram
        
        let sut = DashboardView(viewModel: viewModel)
        
        let scrollView = try sut.inspect().find(ViewType.ScrollView.self)
        let vStack = try scrollView.vStack()
        
        let programsText = try vStack.find(text: "Continue")
        XCTAssertEqual(try programsText.string(), "Continue")
    }

}
