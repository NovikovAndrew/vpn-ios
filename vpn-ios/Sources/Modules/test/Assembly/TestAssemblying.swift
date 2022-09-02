import UIKit

public struct Test { 
    public typealias Configuration = (ModuleInput) -> ModuleOutput?
    public typealias ModuleAssemblying = TestModuleAssemblying
}

public protocol TestModuleAssemblying {
    func assemble(_ configuration: Test.Configuration?) -> UIViewController
}
