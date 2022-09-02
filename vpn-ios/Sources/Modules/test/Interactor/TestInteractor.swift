private typealias Module = Test

extension Module {
    final class Interactor: InteractorInput {
        weak var output: InteractorOutput!
        
        required init() {
        
        }
    }
}
