import Foundation

private typealias Module = Test

extension Module {
    typealias InteractorOutput = TestInteractorOutput
}

protocol TestInteractorOutput: AnyObject {}
