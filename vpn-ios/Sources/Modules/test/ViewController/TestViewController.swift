private typealias Module = Test
private typealias ViewController = Test.ViewController

extension Module {
    final class ViewController: BaseController {

        // MARK: - Dependencies

        var output: ViewOutput?
        
        private lazy var contentView: View = build{<#T##(T) -> Void#>}

        // MARK: - Lifecycle

        override func loadView() {
            super.loadView()
            self.view = contentView
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            output?.didLoad()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            output?.didAppear()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            output?.didDisappear()
        }
    }
}

// MARK: - ViewInput

extension ViewController: Module.ViewInput {
    func display(viewModel: Test.ViewModel) {

    }
}
