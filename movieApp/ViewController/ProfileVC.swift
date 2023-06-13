//
//  ProfileVC.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 20/03/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
        setupConstraints()
        
        if APIService.Auth.User != nil {
            usernameLabel.text = APIService.Auth.User?.username
        }
    }
    
    private func setupViews() {
        if APIService.Auth.User != nil {
            usernameTextField.removeFromSuperview()
            passwordTextField.removeFromSuperview()
            warningLabel.removeFromSuperview()
            loginButton.removeFromSuperview()
            loginViaWebButton.removeFromSuperview()
            
            view.addSubview(profilePicture)
            view.addSubview(usernameLabel)
            view.addSubview(favoriteMoviesButton)
            view.addSubview(logOutButton)
        } else {
            profilePicture.removeFromSuperview()
            usernameLabel.removeFromSuperview()
            favoriteMoviesButton.removeFromSuperview()
            logOutButton.removeFromSuperview()
            
            
            usernameTextField.text = ""
            passwordTextField.text = ""
            
            view.addSubview(usernameTextField)
            view.addSubview(passwordTextField)
            view.addSubview(warningLabel)
            view.addSubview(loginButton)
            view.addSubview(loginViaWebButton)
        }
    }
    
    private func setupConstraints() {
        if APIService.Auth.User != nil {
            NSLayoutConstraint.activate([
                profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                profilePicture.heightAnchor.constraint(equalToConstant: 100),
                profilePicture.widthAnchor.constraint(equalToConstant: 100),
                
                usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                usernameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 40),
                
                favoriteMoviesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                favoriteMoviesButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
                favoriteMoviesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                favoriteMoviesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
            ])
        } else {
            NSLayoutConstraint.activate([
                usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                usernameTextField.heightAnchor.constraint(equalToConstant: 40),
                
                passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
                passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                passwordTextField.heightAnchor.constraint(equalToConstant: 40),
                
                warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                warningLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
                warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loginButton.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 40),
                loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                loginViaWebButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loginViaWebButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
                loginViaWebButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                loginViaWebButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }
    }
    
    lazy private var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy private var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.textContentType = .password
        tf.isSecureTextEntry = true
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy private var warningLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .systemRed
        lbl.numberOfLines = 2
        lbl.text = ""
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy private var loginButton: LoaderButton = {
        let btn = LoaderButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return btn
    }()
    
    lazy private var loginViaWebButton: LoaderButton = {
        let btn = LoaderButton()
        btn.setTitle("Login via Website", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(loginViaWebsite), for: .touchUpInside)
        
        return btn
    }()
    
    lazy private var profilePicture: UIImageView = {
        let img = UIImageView()
        DispatchQueue.main.async {
            img.load(from: "https://secure.gravatar.com/avatar/\(APIService.Auth.User?.avatar.gravatar.hash ?? "").jpg?s=300")
        }
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 50

        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy private var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.text = APIService.Auth.User?.username
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy private var logOutButton: LoaderButton = {
       let btn = LoaderButton()
        btn.setTitle("Log Out", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemRed
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        return btn
    }()
    
    lazy private var favoriteMoviesButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Favorite Movies", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemRed
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(seeFavoriteMovies), for: .touchUpInside)
        
        return btn
    }()
}

extension ProfileVC {
    @objc private func logOut() {
        logOutButton.isLoading = true
        api.logOut {
            self.logOutButton.isLoading = false
            self.setupViews()
            self.setupConstraints()
        }
    }
    
    @objc private func login() {
        loginButton.isLoading = true
        warningLabel.text = ""
        api.getRequestToken(completionHandler: handleRequestToken(success:error:))
    }
    
    @objc private func loginViaWebsite() {
        loginViaWebButton.isLoading = true
        warningLabel.text = ""
        
        api.getRequestToken { success, err in
            if success {
                DispatchQueue.main.async {
                    UIApplication.shared.open(URL(string: self.api.loginViaWebsiteRoute())!, options: [:], completionHandler: nil)
                }
            } else {
                self.warningLabel.text = err?.localizedDescription
                self.loginViaWebButton.isLoading = false
            }
        }
    }
    
    @objc private func seeFavoriteMovies() {
        navigationController?.pushViewController(FavoriteMoviesVC(), animated: true)
    }
    
    func handleRequestToken(success: Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                self.api.login(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "", completionHandler: self.handleLoginRequest(success:error:))
            }
        } else {
            warningLabel.text = error?.localizedDescription
            loginButton.isLoading = false
            loginViaWebButton.isLoading = false
        }
    }
    
    func handleLoginRequest(success: Bool, error: Error?) {
        if success {
            api.createSession(completionHandler: handleSessionResponse(success:error:))
        } else {
            warningLabel.text = error?.localizedDescription
            loginButton.isLoading = false
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        if success {
            api.getCurrentUser(completionHandler: handleGetCurrentUser(success:error:))
        } else {
            warningLabel.text = error?.localizedDescription
            loginButton.isLoading = false
        }
    }
    
    func handleGetCurrentUser(success: Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                self.loginButton.isLoading = false
                self.loginViaWebButton.isLoading = false
                self.tabBarController?.selectedIndex = 0
            }
        } else {
            warningLabel.text = error?.localizedDescription
            loginButton.isLoading = false
        }
    }
}
