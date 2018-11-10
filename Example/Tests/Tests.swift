import XCTest
@testable import AppStoreConnect_Swift_SDK

final class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSigning() {
        let apiConfiguration = APIConfiguration.testConfiguration
        let authenticator = JWTRequestsAuthenticator(apiConfiguration: apiConfiguration)

        XCTAssertEqual(try! authenticator.createBearer(), "Bearer ")
        
    }
    
}
