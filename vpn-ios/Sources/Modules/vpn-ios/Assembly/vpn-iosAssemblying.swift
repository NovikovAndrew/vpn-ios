import UIKit

public struct vpn-ios { 
    public typealias Configuration = (ModuleInput) -> ModuleOutput?
    public typealias ModuleAssemblying = vpn-iosModuleAssemblying
}

public protocol vpn-iosModuleAssemblying {
    func assemble(_ configuration: vpn-ios.Configuration?) -> UIViewController
}
