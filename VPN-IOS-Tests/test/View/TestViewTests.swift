import XCTest
@testable import vpn-ios

private typealias Module = Test

class TestViewTests: XCTestCase {
    private var sut: Module.ViewController!
    private var presenter: PresenterMock!

    override func setUp() {
        super.setUp()
        sut = .init()
        presenter = .init()
        sut.output = presenter
        
        sut.loadViewForTests()
        sut.display(viewModel: .init())
    }

    override func tearDown() {
        super.tearDown()
    }
}

private class PresenterMock: Module.ViewOutput {

}
