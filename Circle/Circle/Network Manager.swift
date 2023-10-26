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
    SystemView.LoadingView.show()
    
    DispatchQueue.global().async {
        let dataBase = Firestore.firestore()
        
        let userCollectionRef = dataBase.collection("users")
        
        userCollectionRef.whereField("profileName", isEqualTo: profileName.lowercased()).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                SystemView.LoadingView.hide()
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                completion(error)
                SystemView.LoadingView.hide()
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
            
            if let imageString = userData.profileImage {
                if let url = URL(string: imageString) {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data, let image = UIImage(data: data) {
                            SharedProfileModel.shared.profileImage = image
                        } else {
                            SharedProfileModel.shared.profileImage = UIImage(named: "BasicUserProfileImage")
                        }
                    }
                    task.resume()
                } else {
                    SharedProfileModel.shared.profileImage = UIImage(named: "BasicUserProfileImage")
                }
            } else {
                SharedProfileModel.shared.profileImage = UIImage(named: "BasicUserProfileImage")
            }
            
            SharedProfileModel.shared.profileName = userData.profileName
            SharedProfileModel.shared.userName = userData.userName
            SharedProfileModel.shared.password = userData.password
            SharedProfileModel.shared.myCircleDigits = userData.myCircleDigits
            SharedProfileModel.shared.myInTheCircleDigits = userData.myInTheCircleDigits
            SharedProfileModel.shared.myPostDigits = userData.myPostDigits
            SharedProfileModel.shared.followerDigits = userData.followerDigits
            SharedProfileModel.shared.followingDigits = userData.followingDigits
            SharedProfileModel.shared.socialValidation = userData.socialValidation
            SharedProfileModel.shared.backgroundImage = userData.backgroundImage
            SharedProfileModel.shared.userCategory = userData.userCategory
            SharedProfileModel.shared.introduction = userData.introduction
            SharedProfileModel.shared.email = userData.email
            SharedProfileModel.shared.phoneNumber = userData.phoneNumber
            SharedProfileModel.shared.birth = userData.birth
            SharedProfileModel.shared.gender = userData.gender
            SharedProfileModel.shared.userID = userData.userID
            
            completion(nil)
            SystemView.LoadingView.hide()
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

func searchUsers(withPrefix prefix: String, completion: @escaping ([SearchResult], Error?) -> Void) {
    DispatchQueue.global().async {
        let dataBase = Firestore.firestore()
        let userCollectionRef = dataBase.collection("users")
        
        userCollectionRef.whereField("profileName", isGreaterThanOrEqualTo: prefix.lowercased())
            .whereField("profileName", isLessThan: prefix + "z")
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion([], error)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    completion([], nil)
                    return
                }
                
                let searchResults = documents.compactMap { document -> SearchResult? in
                    if let profileName = document["profileName"] as? String,
                       let userName = document["userName"] as? String,
                       let socialValidation = document["socialValidation"] as? Bool {
                        
                        var profileImage: UIImage?
                        
                        if let profileImageURL = document["profileImage"] as? String, !profileImageURL.isEmpty {
                            if let url = URL(string: profileImageURL) {
                                let data = try? Data(contentsOf: url)
                                if let data = data {
                                    profileImage = UIImage(data: data)
                                }
                            }
                        }
                        
                        if profileImage == nil {
                            profileImage = UIImage(named: "BasicUserProfileImage")
                        }
                        
                        return SearchResult(profileName: profileName, profileImage: profileImage, userName: userName, socialValidation: socialValidation)
                    }
                    return nil
                }
                
                completion(searchResults, nil)
            }
    }
}



func uploadProfileImage(image: UIImage, userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    SystemView.LoadingView.show()

    DispatchQueue.global().async {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 데이터를 만들 수 없습니다."])))
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageName = UUID().uuidString
        let imageRef = storageRef.child("profile_images/\(imageName).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 업로드 실패"])))
                SystemView.LoadingView.hide()
                return
            }
            
            // 업로드한 이미지의 URL
            imageRef.downloadURL { (url, error) in
                if let imageURL = url {
                    let urlString = imageURL.absoluteString
                    // Firestore에 imageURL 저장
                    let dataBase = Firestore.firestore()
                    let userRef = dataBase.collection("users").document(userID)
                    
                    userRef.setData(["profileImage": urlString], merge: true) { error in
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

func updateProfileName(userID: String, newProfileName: String, completion: @escaping (Error?) -> Void) {
    print("\(userID) : \(newProfileName)")
    DispatchQueue.global().async {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        let userDocumentRef = usersCollection.document(userID)
        let updateFields = ["profileName": newProfileName]
        
        userDocumentRef.updateData(updateFields) { error in
            if let error = error {
                print("프로필 이름 업데이트 실패: \(error.localizedDescription)")
            } else {
                print("프로필 이름 업데이트 성공")
            }
            
            completion(error)
        }
    }
}
