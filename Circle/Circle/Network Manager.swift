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
    
    let userID = generateRandomString(length: 20) // 20자리의 무작위 문자열을 생성합니다.
    let profileName = userData.profileName.lowercased()
    
    let data: [String: Any] = [
        "userID": userID,
        "userName": userData.userName,
        "password": userData.password,
        "email": userData.email ?? "",
        "phoneNumber": userData.phoneNumber ?? "",
        "image": userData.image ?? "",
        "birth": userData.birth ?? "",
        "gender": userData.gender ?? ""
    ]

    dataBase.collection("Users").document("\(profileName)").setData(data, merge: true) { error in
        if let error = error {
            completion(false, error)
        } else {
            completion(true, nil)
        }
    }
}

func fetchUserData(profileName: String, completion: @escaping (UserData?, Error?) -> Void) {
    let dataBase = Firestore.firestore()

    let docRef = dataBase.collection("Users").document(profileName)

    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            if let data = document.data() {
                let userData = UserData(
                    profileName: profileName,
                    userName: data["userName"] as? String ?? "",
                    password: data["password"] as? String ?? "",
                    email: data["email"] as? String,
                    phoneNumber: data["phoneNumber"] as? String,
                    image: data["image"] as? String,
                    birth: data["birth"] as? String,
                    gender: data["gender"] as? String,
                    userID: data["userID"] as? String
                )
                print(userData)
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
