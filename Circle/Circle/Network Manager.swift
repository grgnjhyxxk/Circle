//
//  Network Manager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit
import FirebaseFirestore

func signUpDataUploadServer(userData: UserData, completion: @escaping (Bool, Error?) -> Void) {
    let dataBase = Firestore.firestore()
    
    let userID = userData.userID ?? generateRandomString(length: 20)
    
    let data: [String: Any] = [
        "profileName": userData.profileName.lowercased(),
        "userID": userID,
        "userName": userData.userName,
        "password": userData.password,
        "myCircleDigits": userData.myCircleDigits,
        "myInTheCircleDigits": userData.myInTheCircleDigits,
        "myPostDigits": userData.myPostDigits,
        "followerDigits": userData.followerDigits,
        "followingDigits": userData.followingDigits,
        "socialValidation": userData.socialValidation,
        "introduction": userData.introduction ?? "",
        "email": userData.email ?? "",
        "phoneNumber": userData.phoneNumber ?? "",
        "image": userData.image ?? "",
        "birth": userData.birth ?? "",
        "gender": userData.gender ?? ""
    ]
    
    dataBase.collection("users").document("\(userID)").setData(data, merge: true) { error in
        if let error = error {
            completion(false, error)
        } else {
            completion(true, nil)
        }
    }
}

func fetchUserData(profileName: String, completion: @escaping (UserData?, Error?) -> Void) {
    let dataBase = Firestore.firestore()

    let userCollectionRef = dataBase.collection("users")

    userCollectionRef.whereField("profileName", isEqualTo: profileName.lowercased()).getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(nil, error)
            return
        }

        guard let document = querySnapshot?.documents.first else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
            completion(nil, error)
            return
        }

        let userData = UserData(
            profileName: profileName.lowercased(),
            userName: document["userName"] as? String ?? "",
            password: document["password"] as? String ?? "",
            myCircleDigits: document["myCircleDigits"] as? Int ?? 0,
            myInTheCircleDigits: document["myInTheCircleDigits"] as? Int ?? 0,
            myPostDigits: document["myPostDigits"] as? Int ?? 0,
            followerDigits: document["followerDigits"] as? Int ?? 0,
            followingDigits: document["followingDigits"] as? Int ?? 0,
            socialValidation: document["socialValidation"] as? Bool ?? false,
            introduction: document["introduction"] as? String,
            email: document["email"] as? String,
            phoneNumber: document["phoneNumber"] as? String,
            image: document["image"] as? String,
            birth: document["birth"] as? String,
            gender: document["gender"] as? String,
            userID: document["userID"] as? String
        )
        myDataList.append(userData)
        completion(userData, nil)
    }
}

func comparePasswords(inputPassword: String, savedPassword: String) -> Bool {
    return inputPassword == savedPassword
}

func checkIfProfileNameExists(_ profileName: String, completion: @escaping (Bool, Error?) -> Void) {
    let dataBase = Firestore.firestore()
    let usersRef = dataBase.collection("users").whereField("profileName", isEqualTo: profileName)
    
    usersRef.getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(false, error)
            return
        }
        
        if let documents = querySnapshot?.documents, !documents.isEmpty {
            completion(true, nil)
            
            
        } else {
            completion(false, nil)
        }
    }
}

func searchUsers(withPrefix prefix: String, completion: @escaping ([String], Error?) -> Void) {
    let dataBase = Firestore.firestore()
    let userCollectionRef = dataBase.collection("users")
    
    userCollectionRef.whereField("profileName", isGreaterThanOrEqualTo: prefix.lowercased())
        .whereField("profileName", isLessThan: prefix + "z")  // Ensure only names starting with prefix are retrieved
    
        .getDocuments { (querySnapshot, error) in
            if let error = error {
                completion([], error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion([], nil)
                return
            }
            
            let profileNames = documents.compactMap { $0["profileName"] as? String }
            completion(profileNames, nil)
        }
}
