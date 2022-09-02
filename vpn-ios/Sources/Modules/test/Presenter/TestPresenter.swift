private typealias Module = Test

private typealias Presenter = Test.Presenter

extension Module {
    final class Presenter: ViewOutput {

        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!
        weak var moduleOutput: ModuleOutput!

        // MARK: - Private Properties

        private var configData: ConfigData?
        
        // MARK: - ViewOutput methods
        
        func didLoad() {
            guard let configData = configData else { return }
            view?.display(viewModel: ViewModel())
        }
    }
}

// MARK: - ModuleInput

extension Presenter: Module.ModuleInput {
	func configure(_ data: Test.ConfigData) {
        self.configData = data
    }
}

// MARK: - InteractorOutput

extension Presenter: Module.InteractorOutput {

}
