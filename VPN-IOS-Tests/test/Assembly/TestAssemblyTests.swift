import XCTest
@testable import vpn-ios

private typealias Module = Test

class TestModuleAssemblyTests: XCTestCase {
    func testModuleRegisteredInContainer() {
        let assembly = injector.inject(Module.ModuleAssemblying.self)
        XCTAssertNotNil(assembly, "Test.Module is registered in Swinject container")
    }
    
    func testConfigureModuleForViewController() {
        let assembly = Module.ModuleAssembly(injection: injector)
        
        let vc = assembly.assemble { _ in 
            return nil
        }
        
        guard let viewController = vc as? Module.ViewController else {
            XCTFail("Not a Test.ViewController")
            return
        }

        XCTAssertNotNil(viewController.output, "Test.ViewController is nil after configuration")
        XCTAssertTrue(viewController.output is Module.Presenter, "output is not Test.Presenter")

        let presenter: Module.Presenter? = viewController.output as? Module.Presenter
        XCTAssertNotNil(presenter?.view, "view in Test.Presenter is nil after configuration")
        
    }
}
