private typealias Module = Test

extension Module {
    final class Router: RouterInput {
        weak var viewController: UIViewController!
        
        required init() {
        
        }
    }
}
