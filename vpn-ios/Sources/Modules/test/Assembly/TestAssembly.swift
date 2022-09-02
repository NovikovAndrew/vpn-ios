private typealias Module = Test

extension Module {
    final class ModuleAssembly: BaseModuleAssembly, ModuleAssemblying {
        func assemble(_ configuration: Configuration? = nil) -> UIViewController {
            let presenter: Presenter = .init()

            let viewController: ViewController = .init()
            presenter.view = viewController
            viewController.output = presenter
            
            let router: Router = .init()
            router.viewController = viewController
            presenter.router = router

            let interactor: Interactor = .init()
            interactor.output = presenter
            presenter.interactor = interactor
            presenter.moduleOutput = configuration?(presenter)

            return viewController
        }
    }
}
