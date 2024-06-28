//
//  WelcomeViewModel.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Combine



public protocol WelcomeViewModelProtocol: AnyObject {
    var email: String { get set }
    var password: String { get set }
    var isLoginButtonEnabled: ObservableValue<Bool> { get }
    var error: ObservableValue<Error?> { get }
    var coordinator: WelcomeCoordinator? { get }

    func login()
    func openRegistration()
}

public class WelcomeViewModel: WelcomeViewModelProtocol {
    public private(set) var isLoginButtonEnabled: ObservableValue<Bool> = .init(value: false)
    public private(set) var error: ObservableValue<Error?> = .init(value: nil)

    @Published public var email: String = ""
    @Published public var password: String = ""

    public private(set) weak var coordinator: WelcomeCoordinator?

    private var cancellables = Set<AnyCancellable>()
    private let loginUseCase: LoginUseCaseProtocol

    init(coordinator: WelcomeCoordinator, loginUseCase: LoginUseCaseProtocol) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
        setupBindings()
    }

    public func login() {
        Task {
            do {
                try await loginUseCase.execute(email: email, password: password)
            } catch {
                self.error.value = error
            }
        }
    }
    
    public func openRegistration() {

    }
    
    private func setupBindings() {
        $email.combineLatest($password)
            .map { email, password in
            !email.isEmpty && !password.isEmpty
        }
            .assign(to: &isLoginButtonEnabled.$value)
    }
}
