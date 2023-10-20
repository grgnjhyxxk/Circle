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
    
    var data: [String: Any] = [
        "userID": userID,
        "userName": userData.userName,
        "password": userData.password,
        "myCircleDigits": userData.myCircleDigits,
        "myInTheCircleDigits": userData.myInTheCircleDigits,
        "myPostDigits": userData.myPostDigits,
        "followerDigits": userData.followerDigits,
        "followingDigits": userData.followingDigits,
        "socialValidation": userData.socialValidation,
        "intrduction": userData.intrduction ?? "",
        "email": userData.email ?? "",
        "phoneNumber": userData.phoneNumber ?? "",
        "image": userData.image ?? "",
        "birth": userData.birth ?? "",
        "gender": userData.gender ?? ""
    ]
    
    dataBase.collection("dataBase").document("users").collection(userData.profileName.lowercased()).document("info").setData(data, merge: true) { error in
        if let error = error {
            completion(false, error)
        } else {
            completion(true, nil)
        }
    }
}

func fetchUserData(profileName: String, completion: @escaping (UserData?, Error?) -> Void) {
    let dataBase = Firestore.firestore()

    let docRef = dataBase.collection("dataBase").document("users").collection(profileName.lowercased()).document("info")

    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            if let data = document.data() {
                let userData = UserData(
                    profileName: profileName,
                    userName: data["userName"] as? String ?? "",
                    password: data["password"] as? String ?? "",
                    myCircleDigits: data["myCircleDigits"] as? Int ?? 0,
                    myInTheCircleDigits: data["myInTheCircleDigits"] as? Int ?? 0,
                    myPostDigits: data["myPostDigits"] as? Int ?? 0,
                    followerDigits: data["followerDigits"] as? Int ?? 0,
                    followingDigits: data["followingDigits"] as? Int ?? 0,
                    socialValidation: data["socialValidation"] as? Bool ?? false,
                    intrduction: data["intrduction"] as? String,
                    email: data["email"] as? String,
                    phoneNumber: data["phoneNumber"] as? String,
                    image: data["image"] as? String,
                    birth: data["birth"] as? String,
                    gender: data["gender"] as? String,
                    userID: data["userID"] as? String
                )
                myDataList.append(userData)
                
                completion(userData, nil)
            } else {
                completion(nil, nil)
            }
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
            completion(nil, error)
        }
    }
}

func comparePasswords(inputPassword: String, savedPassword: String) -> Bool {
    return inputPassword == savedPassword
}

func checkIfProfileNameExists(_ profileName: String, completion: @escaping (Bool, Error?) -> Void) {
    let dataBase = Firestore.firestore()
    
    let profileNameRef = dataBase.collection("dataBase").document("users").collection(profileName.lowercased())
    
    profileNameRef.getDocuments { (snapshot, error) in
        if let error = error {
            completion(false, error)
            return
        }
        
        if snapshot?.isEmpty == true {
            completion(false, nil)
        } else {
            completion(true, nil)
        }
    }
}
