//
//  LoginTest.swift
//  LoginTest
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import XCTest
import Delivery

final class LoginTests: XCTestCase {

    private var userSessionManager: UserSessionManagerProtocol!
    private var authRepository: AuthRepository!
    private var loginUseCase: LoginUseCaseProtocol!
    private let correctEmail = "johndoe@gmail.com"
    private let correctPassword = "1234qwer"

    override func setUp() {
        super.setUp()
        userSessionManager = MockUserSessionManager()
        authRepository = MockAuthService(email: correctEmail, password: correctPassword)
        loginUseCase = LoginUseCase(authRepository: authRepository, userSessionManager: userSessionManager)
    }

    func testLoginUseCaseSuccess() async throws {

        // Given

        let email = "johndoe@gmail.com"
        let password = "1234qwer"

        // When/Then

        do {
            try await loginUseCase.execute(email: email, password: password)
            let isAuthorized = userSessionManager.isAuthorized.value
            XCTAssertTrue(isAuthorized, "Login has been succeeded, but the isAuthorized property is false")
        } catch {
            XCTFail("Login should success, but failed with error: \(error)")
        }
    }

    func testLoginUseCaseFailed() async throws {

        // Given

        let email = "johndoe@gmail.com"
        let password = "1234"

        // When/Then

        do {
            try await loginUseCase.execute(email: email, password: password)
            XCTFail("Login should fail, but success")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil")
        }
    }
}
