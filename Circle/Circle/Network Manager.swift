//
//  Network Manager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

func signUpDataUploadServer(userData: UserData, completion: @escaping (Bool, Error?) -> Void) {
    DispatchQueue.global().async {
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
            "backgroundImage": userData.backgroundImage ?? "",
            "profileImage": userData.profileImage ?? "",
            "userCategory": userData.userCategory ?? "",
            "introduction": userData.introduction ?? "",
            "email": userData.email ?? "",
            "phoneNumber": userData.phoneNumber ?? "",
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
}

func fetchUserData(profileName: String, completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let dataBase = Firestore.firestore()
        
        let userCollectionRef = dataBase.collection("users")
        
        userCollectionRef.whereField("profileName", isEqualTo: profileName.lowercased()).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                completion(error)
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
                backgroundImage: document["backgroundImage"] as? String,
                profileImage: document["profileImage"] as? String,
                userCategory: document["userCategory"] as? String,
                introduction: document["introduction"] as? String,
                email: document["email"] as? String,
                phoneNumber: document["phoneNumber"] as? String,
                birth: document["birth"] as? String,
                gender: document["gender"] as? String,
                userID: document["userID"] as? String
            )
            
            loadImage(from: userData.profileImage, fallbackImageName: "BasicUserProfileImage") { (profileImage) in
                SharedProfileModel.myProfile.profileImage = profileImage
            }

            loadImage(from: userData.backgroundImage, fallbackImageName: "") { (backgroundImage) in
                SharedProfileModel.myProfile.backgroundImage = backgroundImage
            }
            
            SharedProfileModel.myProfile.profileName = userData.profileName
            SharedProfileModel.myProfile.userName = userData.userName
            SharedProfileModel.myProfile.password = userData.password
            SharedProfileModel.myProfile.myCircleDigits = userData.myCircleDigits
            SharedProfileModel.myProfile.myInTheCircleDigits = userData.myInTheCircleDigits
            SharedProfileModel.myProfile.myPostDigits = userData.myPostDigits
            SharedProfileModel.myProfile.followerDigits = userData.followerDigits
            SharedProfileModel.myProfile.followingDigits = userData.followingDigits
            SharedProfileModel.myProfile.socialValidation = userData.socialValidation
            SharedProfileModel.myProfile.userCategory = userData.userCategory
            SharedProfileModel.myProfile.introduction = userData.introduction
            SharedProfileModel.myProfile.email = userData.email
            SharedProfileModel.myProfile.phoneNumber = userData.phoneNumber
            SharedProfileModel.myProfile.birth = userData.birth
            SharedProfileModel.myProfile.gender = userData.gender
            SharedProfileModel.myProfile.userID = userData.userID
            
            completion(nil)
        }
    }
}

func comparePasswords(inputPassword: String, savedPassword: String) -> Bool {
    return inputPassword == savedPassword
}

func checkIfProfileNameExists(_ profileName: String, completion: @escaping (Bool, Error?) -> Void) {
    DispatchQueue.global().async {
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
}

func searchUsers(withPrefix prefix: String, completion: @escaping (Error?) -> Void) {
    SharedProfileModel.otherUsersProfiles = []
    
    DispatchQueue.global().async {
        let dataBase = Firestore.firestore()
        let userCollectionRef = dataBase.collection("users")
        
        userCollectionRef.whereField("profileName", isGreaterThanOrEqualTo: prefix.lowercased())
            .whereField("profileName", isLessThan: prefix + "z")
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(error)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    completion(nil)
                    return
                }
                
                for document in documents {
                    if let profileName = document["profileName"] as? String,
                        let userName = document["userName"] as? String,
                        let password = document["password"] as? String,
                        let myCircleDigits = document["myCircleDigits"] as? Int,
                        let myInTheCircleDigits = document["myInTheCircleDigits"] as? Int,
                        let myPostDigits = document["myPostDigits"] as? Int,
                        let followerDigits = document["followerDigits"] as? Int,
                        let followingDigits = document["followingDigits"] as? Int,
                        let socialValidation = document["socialValidation"] as? Bool,
                        let backgroundImage = document["backgroundImage"] as? String,
                        let profileImage = document["profileImage"] as? String,
                        let userCategory = document["userCategory"] as? String,
                        let introduction = document["introduction"] as? String,
                        let email = document["email"] as? String,
                        let phoneNumber = document["phoneNumber"] as? String,
                        let birth = document["birth"] as? String,
                        let gender = document["gender"] as? String,
                        let userID = document["userID"] as? String {
                        
                        let userData = SharedProfileModel()

                        loadImage(from: profileImage, fallbackImageName: "BasicUserProfileImage") { (profileImage) in
                            userData.profileImage = profileImage
                        }

                        loadImage(from: backgroundImage, fallbackImageName: "") { (backgroundImage) in
                            userData.backgroundImage = backgroundImage
                        }

                        userData.profileName = profileName
                        userData.userName = userName
                        userData.password = password
                        userData.myCircleDigits = myCircleDigits
                        userData.myInTheCircleDigits = myInTheCircleDigits
                        userData.myPostDigits = myPostDigits
                        userData.followerDigits = followerDigits
                        userData.followingDigits = followingDigits
                        userData.socialValidation = socialValidation
                        userData.userCategory = userCategory
                        userData.introduction = introduction
                        userData.email = email
                        userData.phoneNumber = phoneNumber
                        userData.birth = birth
                        userData.gender = gender
                        userData.userID = userID

                        SharedProfileModel.otherUsersProfiles.append(userData)
                    }
                }
                
                completion(nil)
            }
    }
}

func uploadImage(field: String, image: UIImage, userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    SystemView.LoadingView.show()

    DispatchQueue.global().async {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 데이터를 만들 수 없습니다."])))
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageName = UUID().uuidString
        let imageRef = storageRef.child("\(field)/\(imageName).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 업로드 실패"])))
                SystemView.LoadingView.hide()
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let imageURL = url {
                    let urlString = imageURL.absoluteString
                    let dataBase = Firestore.firestore()
                    let userRef = dataBase.collection("users").document(userID)
                    
                    userRef.setData(["\(field)": urlString], merge: true) { error in
                        if let error = error {
                            completion(.failure(error))
                            SystemView.LoadingView.hide()
                        } else {
                            completion(.success(()))
                            SystemView.LoadingView.hide()
                        }
                    }
                } else {
                    completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 URL을 가져올 수 없습니다."])))
                    SystemView.LoadingView.hide()
                }
            }
        }
        
        uploadTask.resume()
    }
}

func updateProfileName(field: String, userID: String, updateData: String, completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        let userDocumentRef = usersCollection.document(userID)
        let updateFields = ["\(field)": updateData]
        
        userDocumentRef.updateData(updateFields) { error in
            if let error = error {
                print("\(field) : \(updateData) 업데이트 실패: \(error.localizedDescription)")
            } else {
                print("\(field) : \(updateData)  업데이트 성공")
            }
            
            completion(error)
        }
    }
}
