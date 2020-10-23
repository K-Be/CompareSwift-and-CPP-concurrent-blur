//
//  SwiftBlurTest.swift
//  SwiftBlurTests
//
//  Created by Andrew Romanov on 23.10.2020.
//

import XCTest
import GameKit
@testable import SwiftBlur

class SwiftBlurTest: XCTestCase {

    var sourceData = [Double]()

    override func setUpWithError() throws {
        var values = [Double]()
        let count = 10_000
        values.reserveCapacity(count)
        let random = GKRandomDistribution(lowestValue: 0, highestValue: count - 1)
        for _ in 0..<count {
            let value = random.nextUniform()
            values.append(Double(value))
        }
        self.sourceData = values
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        let blur = SwiftBlur(withSource: self.sourceData, blurRadius: 10)
        let random = GKRandomDistribution(lowestValue: 0, highestValue: self.sourceData.count - 1)
        self.measure {
            let result = blur.blur()
            let randValue = random.nextInt()
            _ = result[randValue]
        }
    }

}
