import UIKit

public struct Networking { 
    public typealias Configuration = (ModuleInput) -> ModuleOutput?
    public typealias ModuleAssemblying = NetworkingModuleAssemblying
}

public protocol NetworkingModuleAssemblying {
    func assemble(_ configuration: Networking.Configuration?) -> UIViewController
}
