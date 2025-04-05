//
//  ElevenTenTests.swift
//  ElevenTenTests
//
//  Created by César Venzor on 20/02/24.
//

import XCTest
@testable import ElevenTen

final class ElevenTenTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let sum = 1 + 2
        XCTAssertEqual(sum, 3)
    }
    
    func testExample2() throws {
        let sum = 1 + 4
        XCTAssertEqual(sum, 5)
    }
    
    func testExample3() throws {
        XCTAssertTrue(1 == 1)
    }
}
