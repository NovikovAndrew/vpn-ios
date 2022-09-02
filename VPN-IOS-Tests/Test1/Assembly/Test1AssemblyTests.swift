import XCTest
@testable import vpn-ios

private typealias Module = Test1

class Test1ModuleAssemblyTests: XCTestCase {
    func testModuleRegisteredInContainer() {
        let assembly = injector.inject(Module.ModuleAssemblying.self)
        XCTAssertNotNil(assembly, "Test1.Module is registered in Swinject container")
    }
    
    func testConfigureModuleForViewController() {
        let assembly = Module.ModuleAssembly(injection: injector)
        
        let vc = assembly.assemble { _ in 
            return nil
        }
        
        guard let viewController = vc as? Module.ViewController else {
            XCTFail("Not a Test1.ViewController")
            return
        }

        XCTAssertNotNil(viewController.output, "Test1.ViewController is nil after configuration")
        XCTAssertTrue(viewController.output is Module.Presenter, "output is not Test1.Presenter")

        let presenter: Module.Presenter? = viewController.output as? Module.Presenter
        XCTAssertNotNil(presenter?.view, "view in Test1.Presenter is nil after configuration")
        
    }
}
