//
//  SceneDelegate.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let loginState = UserDefaults.standard.bool(forKey: "loginState")
        
        if let id = UserDefaults.standard.string(forKey: "userID") {
            if loginState {
                let dispatchGroup = DispatchGroup()
                
                dispatchGroup.enter()
                fetchUserDataUseUserID(userID: id) { error in
                    defer {
                        dispatchGroup.leave()
                    }
                    if let error = error {
                        print("Error fetching user data: \(error.localizedDescription)")
                        self.window?.rootViewController = IntroViewController().isLoggedIn()
                        self.window?.makeKeyAndVisible()
                    }
                }
                
                dispatchGroup.enter()
                retrieveFirstFourPosts { error in
                    defer {
                        dispatchGroup.leave()
                    }
                    if let error = error {
                        print("Error fetching first four posts: \(error.localizedDescription)")
                    } else {
                        print("First four posts retrieved successfully")
                    }
                }
                
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    print("All asynchronous tasks are completed. Continue with the next steps.")
                    
                    let myProfile = SharedProfileModel.myProfile
                    
                    retrieveMyPosts(userID: myProfile.userID!) { (error) in
                        if let error = error {
                            print("Error retrieving user posts: \(error.localizedDescription)")
                        } else {
                            fetchRecentSearchesRecords { error in
                                if let error = error {
                                    print("Error fetching first four posts: \(error.localizedDescription)")
                                } else {
                                    print("RecentSearchesRecords retrieved successfully")
                                    
                                    // 최근 검색 기록에서 "user" 타입인 데이터를 가져옴
                                    for record in SharedRecentSearchesRecordModel.nomarl {
                                        if record.searchesType == "user" {
                                            fetchUserData2(userID: record.searchesData ?? "") { error in
                                                if let error = error {
                                                    print("Error fetching user data: \(error)")
                                                } else {
                                                    
                                                }
                                            }
                                        }
                                    }
                                    
                                    let rootViewController = TabBarController()
                                    rootViewController.modalPresentationStyle = .fullScreen
                                    self.window?.rootViewController = rootViewController
                                    self.window?.makeKeyAndVisible()
                                }
                            }
                        }
                    }
                }
            } else {
                window?.rootViewController = IntroViewController().isLoggedIn()
                window?.makeKeyAndVisible()
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

