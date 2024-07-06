//
//  WelcomeViewController.swift
//  Delivery
//
//  Created by Shmatov Nikita on 27.06.2024.
//

import UIKit
import Combine

public protocol WelcomeViewControllerProtocol: AnyObject {
    var emailTextField: UITextField { get }
    var passwordTextField: UITextField { get }
    var errorLabel: UILabel { get }
    var loginButton: UIButton { get }
    var signUpLabel: UILabel { get }
    var signUpButton: UIButton { get }

    var viewModel: WelcomeViewModelProtocol { get set }
}

final public class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {
    public lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        textField.placeholder = "Email"
        textField.tintColor = UIColor(resource: .A_259_FF)
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.delegate = self
        return textField
    }()

    public lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        textField.placeholder = "Password"
        textField.tintColor = UIColor(resource: .A_259_FF)
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()

    public lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        return label
    }()

    public lazy var loginButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(resource: .A_259_FF), for: .normal)
        button.tintColor = UIColor(resource: ._0_BCE_83)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        return button
    }()

    public lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.text = "New customer?"
        return label
    }()

    public lazy var signUpButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.borderedProminent())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(resource: .A_259_FF), for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Welcome"
        return label
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .welcomeBackgroundCurve))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public var viewModel: any WelcomeViewModelProtocol

    private var cancellables = Set<AnyCancellable>()

    public init(viewModel: WelcomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .A_259_FF)
        setupViews()
        setupActions()
        setupBindings()
        setupHideKeyboardOnTap()
    }
}

extension WelcomeViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            loginButtonTapped()
        default: break
        }
        return true
    }
}

private extension WelcomeViewController {
    func setupViews() {
        // A background image view
        view.addSubview(backgroundImageView)

        // A welcome label

        view.addSubview(welcomeLabel)

        // A vertical stack for input fields and an error label
        let fieldsVStack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, errorLabel])
        fieldsVStack.translatesAutoresizingMaskIntoConstraints = false
        fieldsVStack.axis = .vertical
        fieldsVStack.spacing = 8
        view.addSubview(fieldsVStack)

        // Login button
        view.addSubview(loginButton)

        // A vertical stack for sign up's label and button
        let signUpVStack = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        signUpVStack.translatesAutoresizingMaskIntoConstraints = false
        signUpVStack.axis = .vertical
        signUpVStack.alignment = .center
        signUpVStack.spacing = 4
        view.addSubview(signUpVStack)

        let horizontalSpacing: CGFloat = 16


        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fieldsVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacing),
            fieldsVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacing),
            fieldsVStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signUpVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacing),
            signUpVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacing),
            signUpVStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(lessThanOrEqualTo: signUpVStack.topAnchor, constant: -24),
            loginButton.topAnchor.constraint(equalTo: fieldsVStack.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            welcomeLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            welcomeLabel.bottomAnchor.constraint(greaterThanOrEqualTo: fieldsVStack.topAnchor, constant: -32)
        ])
    }

    func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

    @objc func loginButtonTapped() {
        viewModel.login()
    }

    @objc func signUpButtonTapped() {
        viewModel.openRegistration()
    }

    func setupBindings() {
        // Bind email and password text fields to the viewModel
        emailTextField.textPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)
        passwordTextField.textPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)

        // Bind viewModel's isLoginButtonEnabled to the loginButton's isEnabled property
        viewModel.isLoginButtonEnabled.$value
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)

        // Bind viewModel's error to the errorLabel's text property
        viewModel.error.$value
            .receive(on: RunLoop.main)
            .map(\.?.localizedDescription)
            .assign(to: \.text, on: errorLabel)
            .store(in: &cancellables)
    }
}
