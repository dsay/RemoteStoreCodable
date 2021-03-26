import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RemoteStoreCodableTests.allTests),
    ]
}
#endif
