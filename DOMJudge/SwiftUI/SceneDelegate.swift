//
//  SceneDelegate.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 1/11/24.
//


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // Check if URL is saved in UserDefaults
        if UserDefaults.standard.string(forKey: "DOMJudgeBaseURL") == nil {
            // Show OnboardingViewController if no URL is saved
            window?.rootViewController = OnboardingViewController()
        } else {
            // Show main app if URL is available
            window?.rootViewController = LoginViewController()
        }

        window?.makeKeyAndVisible()
    }
}
