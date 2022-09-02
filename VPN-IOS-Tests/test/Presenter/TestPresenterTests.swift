import XCTest
import TestsUtilities
@testable import vpn-ios

private typealias Module = Test

class TestPresenterTest: XCTestCase {
    private var sut: Module.Presenter!
    private var view: ViewMock!
    private var interactor: InteractorMock!

    override func setUp() {
        super.setUp()
        sut = .init()
        view = .init()
        interactor = .init()
        sut.interactor = interactor
        sut.view = view
        
        sut.configure(.init())
        sut.didLoad()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testViewModel() {
        let vm = view.viewModel
        
    }
}

private class ViewMock: BaseViewInputMock, Module.ViewInput {
    var viewModel: Module.ViewModel?
    func display(viewModel: Module.ViewModel) {
        self.viewModel = viewModel
    }
}

private class InteractorMock: Module.InteractorInput {

}
