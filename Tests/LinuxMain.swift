import XCTest

import foreverTests

var tests = [XCTestCaseEntry]()
tests += foreverTests.allTests()
XCTMain(tests)
