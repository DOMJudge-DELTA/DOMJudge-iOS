import UIKit

class OnboardingViewController: UIViewController {

    // UI Elements
    private let urlTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter DOMjudge URL"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save URL", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    private func setupLayout() {
        // Add subviews
        view.addSubview(urlTextField)
        view.addSubview(errorLabel)
        view.addSubview(saveButton)

        // Set up constraints
        NSLayoutConstraint.activate([
            urlTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urlTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            errorLabel.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20)
        ])
    }

    @objc private func saveButtonTapped() {
        guard let urlString = urlTextField.text, !urlString.isEmpty else {
            errorLabel.text = "Please enter a valid URL."
            errorLabel.isHidden = false
            return
        }

        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            saveURLToUserDefaults(urlString)
            navigateToMainApp()
        } else {
            errorLabel.text = "Invalid URL format. Please try again."
            errorLabel.isHidden = false
        }
    }

    private func saveURLToUserDefaults(_ urlString: String) {
        UserDefaults.standard.set(urlString, forKey: "DOMJudgeBaseURL")
    }

    private func navigateToMainApp() {
        // Transition to main view controller
        let loginVC = LoginViewController()
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }
}
