private typealias Module = Test
private typealias ViewController = Test.ViewController

extension ViewController {
    final class View: BaseView {
        override func resolveSubviews() {
            super.resolveSubviews()
        }
    }
}