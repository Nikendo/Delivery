//
//  LoginUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.09.2024.
//


public final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute(email: String, password: String) async throws {
        let _ = try await authRepository.signIn(email: email, password: password)
    }
}
