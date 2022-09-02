private typealias Module = Test

extension Module {
    typealias ViewInput = TestViewInput
    typealias ViewOutput = TestViewOutput
}

protocol TestViewOutput: BaseViewOutput {}

protocol TestViewInput: BaseViewInput {
    func display(viewModel: Test.ViewModel)
}
