import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(JWTRequestsAuthenticatorTests.allTests),
        testCase(JWTTests.allTests)
    ]
}
#endif
