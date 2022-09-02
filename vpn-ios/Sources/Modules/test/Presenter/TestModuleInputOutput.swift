private typealias Module = Test

extension Module {
    public typealias ModuleInput = TestModuleInput
    public typealias ModuleOutput = TestModuleOutput

    public struct ConfigData {
        public init() {}
    }
}

public protocol TestModuleInput: AnyObject {
    func configure(_ data: Test.ConfigData)
}

public protocol TestModuleOutput: AnyObject {}
