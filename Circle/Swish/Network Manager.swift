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
            "signDate": userData.signDate,
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

func fetchUserDataUseProfileName(profileName: String, completion: @escaping (Error?) -> Void) {
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
                signDate:  document["signDate"] as? String ?? "",
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

func fetchUserDataUseUserID(userID: String, completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let dataBase = Firestore.firestore()
        
        let userDocumentRef = dataBase.collection("users").document(userID)
        
        userDocumentRef.getDocument { (document, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = document, document.exists else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                completion(error)
                return
            }
            
            let userData = UserData(
                signDate:  document["signDate"] as? String ?? "",
                profileName: document["profileName"] as? String ?? "",
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
                userID: document.documentID
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


func fetchUserData2(userID: String, completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let dataBase = Firestore.firestore()
        
        let sharedProfileModel = SharedProfileModel()
        let userDocumentRef = dataBase.collection("users").document(userID)
        
        userDocumentRef.getDocument { (document, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = document, document.exists else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                completion(error)
                return
            }
            
            var userData = UserData(
                signDate:  document["signDate"] as? String ?? "",
                profileName: document["profileName"] as? String ?? "",
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
                sharedProfileModel.profileImage = profileImage
            }
            
            loadImage(from: userData.backgroundImage, fallbackImageName: "") { (backgroundImage) in
                sharedProfileModel.backgroundImage = backgroundImage
            }
            
            sharedProfileModel.profileName = userData.profileName
            sharedProfileModel.userName = userData.userName
            sharedProfileModel.password = userData.password
            sharedProfileModel.myCircleDigits = userData.myCircleDigits
            sharedProfileModel.myInTheCircleDigits = userData.myInTheCircleDigits
            sharedProfileModel.myPostDigits = userData.myPostDigits
            sharedProfileModel.followerDigits = userData.followerDigits
            sharedProfileModel.followingDigits = userData.followingDigits
            sharedProfileModel.socialValidation = userData.socialValidation
            sharedProfileModel.userCategory = userData.userCategory
            sharedProfileModel.introduction = userData.introduction
            sharedProfileModel.email = userData.email
            sharedProfileModel.phoneNumber = userData.phoneNumber
            sharedProfileModel.birth = userData.birth
            sharedProfileModel.gender = userData.gender
            sharedProfileModel.userID = userData.userID
            
            SharedProfileModel.recentSearchesRecordProfiles.append(sharedProfileModel)
            
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
    SharedProfileModel.searchUsersProfiles = []

    DispatchQueue.global().async {
        let dataBase = Firestore.firestore()
        let userCollectionRef = dataBase.collection("users")

        // Search by profileName
        let profileNameQuery = userCollectionRef
            .whereField("profileName", isGreaterThanOrEqualTo: prefix.lowercased())
            .whereField("profileName", isLessThan: prefix + "z")

        profileNameQuery.getDocuments { (profileNameQuerySnapshot, profileNameError) in
            if let profileNameError = profileNameError {
                completion(profileNameError)
                return
            }

            if let profileNameDocuments = profileNameQuerySnapshot?.documents {
                handleQueryResults(documents: profileNameDocuments)
            }

            // Search by userName
            let userNameQuery = userCollectionRef
                .order(by: "userName")
                .start(at: [prefix])
                .end(at: [prefix + "\u{f8ff}"])

            userNameQuery.getDocuments { (userNameQuerySnapshot, userNameError) in
                if let userNameError = userNameError {
                    completion(userNameError)
                    return
                }

                if let userNameDocuments = userNameQuerySnapshot?.documents {
                    handleQueryResults(documents: userNameDocuments)
                }

                completion(nil)
            }
        }
    }
}

private func handleQueryResults(documents: [QueryDocumentSnapshot]) {
    for document in documents {
        guard let profileName = document["profileName"] as? String,
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
              let userID = document["userID"] as? String else {
            continue
        }

        let userData = SharedProfileModel()
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

        loadImage(from: profileImage, fallbackImageName: "BasicUserProfileImage") { (profileImage) in
            userData.profileImage = profileImage
        }

        loadImage(from: backgroundImage, fallbackImageName: "") { (backgroundImage) in
            userData.backgroundImage = backgroundImage
        }

        SharedProfileModel.searchUsersProfiles.append(userData)
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

func updateProfile(field: String, userID: String, updateData: String, completion: @escaping (Error?) -> Void) {
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

func uploadPostData(postData: PostData, postID: String, images: [UIImage], userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    uploadImages(field: "posts", images: images, userID: userID) { result in
        switch result {
        case .success(let uploadedImageURLs):
            let dataBase = Firestore.firestore()
            let userCollectionRef = dataBase.collection("users").document(userID).collection("posts")
            
            // Combine data for both user collection and post collection
            var data: [String: Any] = [
                "postID": postID,
                "userID": postData.userID,
                "content": postData.content,
                "date": postData.date,
                "location": postData.location,
                "like": postData.like ?? [],
                "saved": postData.saved ?? [],
                "shared": postData.shared ?? [],
                "comments": postData.comments ?? 0,
                "views": postData.views ?? [],
                "images": uploadedImageURLs // Add image URLs to the post data
            ]
            
            // Set data to user collection
            userCollectionRef.document(postID).setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                    print("Error adding document to user collection: \(error.localizedDescription)")
                } else {
                    // Set data to post collection
                    let postCollectionRef = dataBase.collection("posts")
                    postCollectionRef.document(postID).setData(data) { error in
                        if let error = error {
                            completion(.failure(error))
                            print("Error adding document to post collection: \(error.localizedDescription)")
                        } else {
                            completion(.success(()))
                            print("Document added successfully to both collections")
                        }
                    }
                }
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

func updatePostData(postID: String, updatedPostData: PostData, updatedImages: [UIImage], userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    uploadImages(field: "posts", images: updatedImages, userID: userID) { result in
        switch result {
        case .success(let uploadedImageURLs):
            let dataBase = Firestore.firestore()
            let userCollectionRef = dataBase.collection("users").document(userID).collection("posts")
            let postCollectionRef = dataBase.collection("posts")

            var updatedData: [String: Any] = [
                "content": updatedPostData.content,
                "location": updatedPostData.location,
                "images": uploadedImageURLs // 업데이트된 이미지 URL을 게시물 데이터에 추가
            ]

            // 사용자 컬렉션에서 특정 필드만 업데이트
            userCollectionRef.document(postID).updateData(updatedData) { userError in
                if let userError = userError {
                    completion(.failure(userError))
                    print("사용자 문서 업데이트 중 오류 발생: \(userError.localizedDescription)")
                } else {
                    // 전체 게시물 컬렉션에서도 업데이트
                    postCollectionRef.document(postID).updateData(updatedData) { postError in
                        if let postError = postError {
                            completion(.failure(postError))
                            print("게시물 문서 업데이트 중 오류 발생: \(postError.localizedDescription)")
                        } else {
                            completion(.success(()))
                            print("문서 업데이트 성공")
                        }
                    }
                }
            }

        case .failure(let error):
            completion(.failure(error))
        }
    }
}

func updatePostLikes(postID: String, updatedLikes: [String], userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let dataBase = Firestore.firestore()
    let userCollectionRef = dataBase.collection("users").document(userID).collection("posts")
    let postCollectionRef = dataBase.collection("posts")

    let updatedData: [String: Any] = [
        "like": updatedLikes // 업데이트된 좋아요 목록을 게시물 데이터에 추가
    ]

    // 사용자 컬렉션에서 특정 필드만 업데이트
    userCollectionRef.document(postID).updateData(updatedData) { userError in
        if let userError = userError {
            completion(.failure(userError))
            print("사용자 문서 업데이트 중 오류 발생: \(userError.localizedDescription)")
        } else {
            // 전체 게시물 컬렉션에서도 업데이트
            postCollectionRef.document(postID).updateData(updatedData) { postError in
                if let postError = postError {
                    completion(.failure(postError))
                    print("게시물 문서 업데이트 중 오류 발생: \(postError.localizedDescription)")
                } else {
                    completion(.success(()))
                    print("문서 업데이트 성공")
                }
            }
        }
    }
}

func updateCommentLikes(rootID: String, userID: String, postUserID: String, documentID: String, updatedLikes: [String], completion: @escaping (Result<Void, Error>) -> Void) {
    let dataBase = Firestore.firestore()

    // 댓글 작성자 본인의 문서에서 좋아요 업데이트
    let userCollectionRef = dataBase.collection("users").document(userID).collection("comments")
    let userCommentDocRef = userCollectionRef.document(documentID)
    
    // 해당 게시글의 댓글 컬렉션에서 좋아요 업데이트
    let postCollectionRef = dataBase.collection("posts").document(rootID).collection("comments")
    let postCommentDocRef = postCollectionRef.document(documentID)
    
    // 게시물을 작성한 사용자의 게시물 컬렉션에서 좋아요 업데이트
    let postUserCollectionRef = dataBase.collection("users").document(postUserID).collection("posts").document(rootID).collection("comments")
    let postUserCommentDocRef = postUserCollectionRef.document(documentID)

    let updatedData: [String: Any] = [
        "like": updatedLikes // 업데이트된 좋아요 목록을 댓글 데이터에 추가
    ]

    // 사용자 컬렉션의 댓글에서 좋아요 업데이트
    userCommentDocRef.updateData(updatedData) { userCommentError in
        if let userCommentError = userCommentError {
            completion(.failure(userCommentError))
            print("사용자 댓글 문서 업데이트 중 오류 발생: \(userCommentError.localizedDescription)")
        } else {
            // 해당 게시글의 댓글 컬렉션에서 좋아요 업데이트
            postCommentDocRef.updateData(updatedData) { postCommentError in
                if let postCommentError = postCommentError {
                    completion(.failure(postCommentError))
                    print("게시글 댓글 문서 업데이트 중 오류 발생: \(postCommentError.localizedDescription)")
                } else {
                    // 게시물을 작성한 사용자의 게시물 컬렉션에서 좋아요 업데이트
                    postUserCommentDocRef.updateData(updatedData) { postUserCommentError in
                        if let postUserCommentError = postUserCommentError {
                            completion(.failure(postUserCommentError))
                            print("게시물 작성자의 포스트 댓글 문서 업데이트 중 오류 발생: \(postUserCommentError.localizedDescription)")
                        } else {
                            completion(.success(()))
                            print("문서 업데이트 성공")
                        }
                    }
                }
            }
        }
    }
}

func uploadImages(field: String, images: [UIImage], userID: String, completion: @escaping (Result<[String], Error>) -> Void) {
    var uploadedImageURLs: [String] = []
    let dispatchGroup = DispatchGroup()

    for image in images {
        dispatchGroup.enter()

        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            dispatchGroup.leave()
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image data."])))
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageName = UUID().uuidString
        let imageRef = storageRef.child("\(field)/\(imageName).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                dispatchGroup.leave()
                completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to upload image."])))
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let imageURL = url {
                    let urlString = imageURL.absoluteString
                    uploadedImageURLs.append(urlString)
                } else {
                    dispatchGroup.leave()
                    completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image URL."])))
                }
                dispatchGroup.leave()
            }
        }
        
        uploadTask.resume()
    }
    
    dispatchGroup.notify(queue: .main) {
        completion(.success(uploadedImageURLs))
    }
}

// 첫 번째 함수: 처음 10개의 게시글을 불러오는 함수
func retrieveFirstFourPosts(completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let database = Firestore.firestore()
        let postCollectionRef = database.collection("posts")
        
        // 추가: 날짜 기준으로 정렬
        postCollectionRef.order(by: "date", descending: true).limit(to: 10).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            if snapshot?.documents.isEmpty ?? true {
                // If the collection is empty, return success
                completion(nil)
                return
            }
            
            var retrievedPosts = [SharedPostModel]()
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot?.documents ?? [] {
                let post = SharedPostModel()
                post.postID = document.data()["postID"] as? String
                post.userID = document.data()["userID"] as? String
                post.content = document.data()["content"] as? String
                post.date = document.data()["date"] as? String
                post.location = document.data()["location"] as? String
                post.like = document.data()["like"] as? [String]
                post.saved = document.data()["saved"] as? [String]
                post.shared = document.data()["shared"] as? [Int: String]
                post.comments = document.data()["comments"] as? Int ?? 0
                post.views = document.data()["views"] as? [String]
                
                if let imageUrls = document.data()["images"] as? [String] {
                    var images = [UIImage]()

                    for imageUrlString in imageUrls {
                        dispatchGroup.enter()

                        loadImage(from: imageUrlString, fallbackImageName: "PlaceholderImage") { (image) in
                            images.append(image)
                            dispatchGroup.leave()
                        }
                    }

                    dispatchGroup.notify(queue: .main) {
                        post.images = images
                        retrievedPosts.append(post)

                        if retrievedPosts.count == snapshot?.documents.count {
                            SharedPostModel.othersPosts = retrievedPosts
                            
                            // 게시글 작성자의 프로필 정보를 불러오고 배열에 추가
                            fetchProfileInfoForPosts(completion: completion)
                        }
                    }
                } else {
                    retrievedPosts.append(post)
                }
            }
        }
    }
}

// 두 번째 함수: 다음 4개의 게시글을 추가로 불러오는 함수
func retrieveNextFourPosts(completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let database = Firestore.firestore()
        let postCollectionRef = database.collection("posts")
        
        let lastPost = SharedPostModel.othersPosts.last ?? SharedPostModel()

        let lastDate = lastPost.date ?? ""
        postCollectionRef.order(by: "date", descending: true).start(after: [lastDate]).limit(to: 10).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                completion(nil)
                return
            }
            
            var retrievedPosts = SharedPostModel.othersPosts
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot?.documents ?? [] {
                let post = SharedPostModel()
                post.postID = document.data()["postID"] as? String
                post.userID = document.data()["userID"] as? String
                post.content = document.data()["content"] as? String
                post.date = document.data()["date"] as? String
                post.location = document.data()["location"] as? String
                post.like = document.data()["like"] as? [String]
                post.saved = document.data()["saved"] as? [String]
                post.shared = document.data()["shared"] as? [Int: String]
                post.comments = document.data()["comments"] as? Int ?? 0
                post.views = document.data()["views"] as? [String]
                
                if let imageUrls = document.data()["images"] as? [String], !imageUrls.isEmpty {
                    var images = [UIImage]()

                    for imageUrlString in imageUrls {
                        dispatchGroup.enter()

                        loadImage(from: imageUrlString, fallbackImageName: "PlaceholderImage") { (image) in
                            images.append(image)
                            dispatchGroup.leave()
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        post.images = images
                        retrievedPosts.append(post)
                        
                        // 모든 포스트를 가져온 경우 완료 처리
                        if retrievedPosts.count >= snapshot?.documents.count ?? 0 {
                            SharedPostModel.othersPosts = retrievedPosts
                            
                            // 게시글 작성자의 프로필 정보를 불러오고 배열에 추가
                            fetchProfileInfoForPosts(completion: completion)
                        }
                    }
                } else {
                    // 이미지가 없는 경우에도 포스트 추가
                    retrievedPosts.append(post)
                    
                    // 모든 포스트를 가져온 경우 완료 처리
                    if retrievedPosts.count >= snapshot?.documents.count ?? 0 {
                        SharedPostModel.othersPosts = retrievedPosts
                        
                        // 게시글 작성자의 프로필 정보를 불러오고 배열에 추가
                        fetchProfileInfoForPosts(completion: completion)
                    }
                }
            }
        }
    }
}

// 게시글 작성자의 프로필 정보를 불러오는 함수
func fetchProfileInfoForPosts(completion: @escaping (Error?) -> Void) {
    let dispatchGroup = DispatchGroup()
    var uniqueUserIDs = Set<String>()  // Set을 사용하여 중복된 유저 ID를 방지

    for post in SharedPostModel.othersPosts {
        guard let userID = post.userID, !uniqueUserIDs.contains(userID) else {
            continue  // 이미 추가된 유저 ID면 skip
        }

        dispatchGroup.enter()
        uniqueUserIDs.insert(userID)

        // users 컬렉션에서 userID에 해당하는 문서의 정보를 가져옴
        let userDocRef = Firestore.firestore().collection("users").document(userID)
        userDocRef.getDocument { (document, error) in
            defer { dispatchGroup.leave() }

            if let error = error {
                print("Error fetching user profile:", error.localizedDescription)
                return
            }

            if let document = document, document.exists {
                guard let profileName = document["profileName"] as? String,
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
                      let userID = document["userID"] as? String else {
                    return
                }
                
                
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
                    
                SharedProfileModel.postsProfiles.append(userData)
            }
        }
    }

    dispatchGroup.notify(queue: .main) {
        // 모든 프로필 정보를 가져왔을 때 completion을 호출
        completion(nil)
    }
}

func retrieveMyPosts(userID: String, completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let database = Firestore.firestore()
        let postCollectionRef = database.collection("users").document(userID).collection("posts")
        
        postCollectionRef.order(by: "date", descending: true).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            if snapshot?.documents.isEmpty ?? true {
                // If the collection is empty, return success
                completion(nil)
                return
            }
            
            var retrievedPosts = [SharedPostModel]()
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot?.documents ?? [] {
                let post = SharedPostModel()
                post.postID = document.data()["postID"] as? String
                post.userID = document.data()["userID"] as? String
                post.content = document.data()["content"] as? String
                post.date = document.data()["date"] as? String
                post.location = document.data()["location"] as? String
                post.like = document.data()["like"] as? [String]
                post.saved = document.data()["saved"] as? [String]
                post.shared = document.data()["shared"] as? [Int: String]
                post.comments = document.data()["comments"] as? Int ?? 0
                post.views = document.data()["views"] as? [String]
                
                if let imageUrls = document.data()["images"] as? [String] {
                    var images = [UIImage]()
                    
                    for imageUrlString in imageUrls {
                        dispatchGroup.enter()
                        
                        loadImage(from: imageUrlString, fallbackImageName: "PlaceholderImage") { (image) in
                            images.append(image)
                            dispatchGroup.leave()  // 이미지 로딩이 완료되면 leave 호출
                        }
                    }
                    
                    // 이미지 로딩이 완료되지 않은 상태에서 notify 클로저 호출되지 않도록
                    dispatchGroup.notify(queue: .main) {
                        post.images = images
                        retrievedPosts.append(post)
                        
                        if retrievedPosts.count == snapshot?.documents.count {
                            // 정렬된 데이터를 저장
                            
                            if userID == SharedProfileModel.myProfile.userID {
                                SharedPostModel.myPosts = retrievedPosts
                                completion(nil)
                            } else {
                                SharedPostModel.searchUserPosts = retrievedPosts
                                completion(nil)
                            }
                        }
                    }
                } else {
                    retrievedPosts.append(post)
                }
            }
        }
    }
}

func deletePost(userID: String, postID: String, completion: @escaping (Error?) -> Void) {
    let dataBase = Firestore.firestore()

    let userCollectionRef = dataBase.collection("users").document(userID).collection("posts").document(postID)
    let postCollectionRef = dataBase.collection("posts").document(postID)

    // Delete post from 'users' collection
    userCollectionRef.delete { userError in
        if let userError = userError {
            completion(userError)
            print("Error deleting user post document: \(userError.localizedDescription)")
            return
        }

        // Delete post from 'posts' collection
        postCollectionRef.delete { postError in
            if let postError = postError {
                completion(postError)
                print("Error deleting post document: \(postError.localizedDescription)")
            } else {
                completion(nil)
                print("Post deleted successfully")
            }
        }
    }
}

func fetchLikeUsersProfiles(forPostID postID: String, completion: @escaping (Error?) -> Void) {
    SharedProfileModel.likeUserProfilesForPost = []
    
    let dispatchGroup = DispatchGroup()
    var uniqueUserIDs = Set<String>()  // Set을 사용하여 중복된 유저 ID를 방지

    let db = Firestore.firestore()
    let postRef = db.collection("posts").document(postID)

    postRef.getDocument { (postSnapshot, postError) in
        if let postError = postError {
            completion(postError)
            return
        }

        guard let postData = postSnapshot?.data(),
              let likeUserIDs = postData["like"] as? [String] else {
            // No like field or no like users, return without error
            completion(nil)
            return
        }
                
        for userID in likeUserIDs {
            guard !uniqueUserIDs.contains(userID) else {
                continue  // 이미 추가된 유저 ID면 skip
            }

            uniqueUserIDs.insert(userID)
            dispatchGroup.enter()

            let userRef = db.collection("users").document(userID)
            userRef.getDocument { (document, error) in
                defer { dispatchGroup.leave() }

                if let error = error {
                    print("Error fetching user profile:", error.localizedDescription)
                    return
                }

                guard let document = document, document.exists,
                      let profileName = document["profileName"] as? String,
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
                      let userID = document["userID"] as? String else {
                    return
                }

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
                
                SharedProfileModel.likeUserProfilesForPost.append(userData)
                
                // 마지막 프로필이 추가되었을 때 completion 클로저 호출
                if SharedProfileModel.likeUserProfilesForPost.count == likeUserIDs.count {
                    completion(nil)
                }
            }
        }
    }

    dispatchGroup.notify(queue: .main) {
        // 모든 프로필 정보를 가져왔을 때 UI 업데이트 수행
        print("Like users profiles fetched successfully")
        print("Total", SharedProfileModel.likeUserProfilesForPost.count)
    }
}

func fetchLikeUsersProfilesForComment(rootID: String, documentID: String, completion: @escaping (Error?) -> Void) {
    SharedProfileModel.likeUserProfilesForComment = []
    
    let dispatchGroup = DispatchGroup()
    var uniqueUserIDs = Set<String>()  // Set을 사용하여 중복된 유저 ID를 방지

    let db = Firestore.firestore()
    let postRef = db.collection("posts").document(rootID).collection("comments").document(documentID)

    postRef.getDocument { (postSnapshot, postError) in
        if let postError = postError {
            completion(postError)
            return
        }

        guard let postData = postSnapshot?.data(),
              let likeUserIDs = postData["like"] as? [String] else {
            // No like field or no like users, return without error
            completion(nil)
            return
        }
                
        for userID in likeUserIDs {
            guard !uniqueUserIDs.contains(userID) else {
                continue  // 이미 추가된 유저 ID면 skip
            }

            uniqueUserIDs.insert(userID)
            dispatchGroup.enter()

            let userRef = db.collection("users").document(userID)
            userRef.getDocument { (document, error) in
                defer { dispatchGroup.leave() }

                if let error = error {
                    print("Error fetching user profile:", error.localizedDescription)
                    return
                }

                guard let document = document, document.exists,
                      let profileName = document["profileName"] as? String,
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
                      let userID = document["userID"] as? String else {
                    return
                }

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
                
                SharedProfileModel.likeUserProfilesForComment.append(userData)
                
                // 마지막 프로필이 추가되었을 때 completion 클로저 호출
                if SharedProfileModel.likeUserProfilesForComment.count == likeUserIDs.count {
                    completion(nil)
                }
            }
        }
    }

    dispatchGroup.notify(queue: .main) {
        // 모든 프로필 정보를 가져왔을 때 UI 업데이트 수행
        print("Like users profiles fetched successfully")
        print("Total", SharedProfileModel.likeUserProfilesForComment.count)
    }
}

func fetchAllUsersProfiles(completion: @escaping (Error?) -> Void) {
    SharedProfileModel.recommendationsProfiles = []
    
    let dispatchGroup = DispatchGroup()
    
    let db = Firestore.firestore()
    let usersRef = db.collection("users")

    usersRef.getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(error)
            return
        }
        
        guard let documents = querySnapshot?.documents else {
            // No documents found, return without error
            completion(nil)
            return
        }

        for document in documents {
            dispatchGroup.enter()

            guard let profileName = document["profileName"] as? String,
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
                  let userID = document["userID"] as? String else {
                continue
            }

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
            
            SharedProfileModel.recommendationsProfiles.append(userData)
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            // 모든 프로필 정보를 가져왔을 때 UI 업데이트 수행
            completion(nil)
        }
    }
}

func uploadCommentData(rootID: String, parentID: String, commentData: CommentData, images: [UIImage], userID: String, postUserID: String, completion: @escaping (Result<CommentData, Error>) -> Void) {
    uploadImages(field: "comments", images: images, userID: userID) { result in
        switch result {
        case .success(let uploadedImageURLs):
            let dataBase = Firestore.firestore()
            
            //댓글 작성자 본인의 문서에 본인 댓글 저장용 경로
            let userCollectionRef = dataBase.collection("users").document(userID).collection("comments")
            let commentID = generateRandomString(length: 20)
            
            // 작성한 댓글의 게시글 문서에 댓글 저장용 경로
            let postCollectionRef = dataBase.collection("posts").document(rootID).collection("comments")
            
            // 작성한 댓글의 게시글의 주인 유저의 문서에 포스트에 댓글 저장용 경로
            let ref = dataBase.collection("users").document(postUserID).collection("posts").document(rootID).collection("comments")
            
            let data: [String: Any] = [
                "rootID": rootID,
                "parentID": parentID,
                "commentID": commentID,
                "userID": commentData.userID,
                "content": commentData.content,
                "date": commentData.date,
                "location": commentData.location,
                "like": commentData.like ?? [],
                "saved": commentData.saved ?? [],
                "shared": commentData.shared ?? [],
                "comments": commentData.comments ?? 0,
                "views": commentData.views ?? [],
                "images": uploadedImageURLs // Add image URLs to the post data
            ]
            
            
            userCollectionRef.document(commentID).setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    postCollectionRef.document(commentID).setData(data) { error in
                        if let error = error {
                            completion(.failure(error))
                            print("Error adding document: \(error.localizedDescription)")
                        } else {
                            ref.document(commentID).setData(data) { error in
                                if let error = error {
                                    completion(.failure(error))
                                } else {
                                    // Increment comment count in the parent post document
                                    let postRef = Firestore.firestore().collection("posts").document(rootID)
                                    postRef.updateData(["comments": FieldValue.increment(Int64(1))]) { error in
                                        if let error = error {
                                            completion(.failure(error))
                                            print("Error incrementing comment count: \(error.localizedDescription)")
                                        } else {
                                            let postRef = dataBase.collection("users").document(postUserID).collection("posts").document(rootID)
                                            postRef.updateData(["comments": FieldValue.increment(Int64(1))]) { error in
                                                if let error = error {
                                                    completion(.failure(error))
                                                    print("Error incrementing comment count: \(error.localizedDescription)")
                                                } else{
                                                    // Create uploaded comment data
                                                    let uploadedCommentData = CommentData(rootID: rootID, parentID: parentID, commentID: commentID, userID: commentData.userID, content: commentData.content, date: commentData.date, location: commentData.location, images: images, like: [], saved: [], shared: [:], comments: 0, views: [])
                                                    
                                                    // Call completion handler with success and uploaded comment data
                                                    completion(.success(uploadedCommentData))
                                                    print("Document added successfully")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

let dataBase = Firestore.firestore()
let dispatchGroup = DispatchGroup()

func deleteComment(commentID: String, rootID: String, userID: String, postUserID: String, completion: @escaping (Result<Void, Error>) -> Void) {
    // 댓글 작성자 본인의 문서에서 댓글 삭제
    let userCollectionRef = dataBase.collection("users").document(userID).collection("comments")
    deleteDocument(collectionRef: userCollectionRef, documentID: commentID)
    
    // 해당 게시글의 댓글 컬렉션에서 댓글 삭제
    let postCollectionRef = dataBase.collection("posts").document(rootID).collection("comments")
    deleteDocument(collectionRef: postCollectionRef, documentID: commentID)
    
    // 게시물을 작성한 사용자의 게시물 컬렉션에서 댓글 삭제
    let postUserCollectionRef = dataBase.collection("users").document(postUserID).collection("posts").document(rootID).collection("comments")
    deleteDocument(collectionRef: postUserCollectionRef, documentID: commentID)
    
    dispatchGroup.notify(queue: .main) {
        // 모든 작업이 완료된 후 실행되는 코드
        let postRef = Firestore.firestore().collection("posts").document(rootID)
        postRef.updateData(["comments": FieldValue.increment(Int64(-1))]) { error in
            if let error = error {
                completion(.failure(error))
                print("Error decrementing comment count: \(error.localizedDescription)")
            } else {
                let postRef = Firestore.firestore().collection("users").document(postUserID).collection("posts").document(rootID)
                postRef.updateData(["comments": FieldValue.increment(Int64(-1))]) { error in
                    if let error = error {
                        completion(.failure(error))
                        print("Error decrementing comment count: \(error.localizedDescription)")
                    } else {
                        completion(.success(()))
                        print("Document deleted successfully")
                    }
                }
            }
        }
    }
}

private func deleteDocument(collectionRef: CollectionReference, documentID: String) {
    dispatchGroup.enter()
    collectionRef.document(documentID).delete { error in
        if let error = error {
            // 에러 처리
            print("Error deleting document: \(error.localizedDescription)")
        }
        dispatchGroup.leave()
    }
}

// 게시글 작성자의 프로필 정보를 불러오는 함수
func fetchProfileInfoForComments(completion: @escaping (Error?) -> Void) {
    let dispatchGroup = DispatchGroup()
    var uniqueUserIDs = Set<String>()  // Set을 사용하여 중복된 유저 ID를 방지

    for comment in SharedCommentModel.comments {
        guard let userID = comment.userID, !uniqueUserIDs.contains(userID) else {
            continue  // 이미 추가된 유저 ID면 skip
        }

        dispatchGroup.enter()
        uniqueUserIDs.insert(userID)

        // users 컬렉션에서 userID에 해당하는 문서의 정보를 가져옴
        let userDocRef = Firestore.firestore().collection("users").document(userID)
        userDocRef.getDocument { (document, error) in
            defer { dispatchGroup.leave() }

            if let error = error {
                print("Error fetching user profile:", error.localizedDescription)
                return
            }

            if let document = document, document.exists {
                guard let profileName = document["profileName"] as? String,
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
                      let userID = document["userID"] as? String else {
                    return
                }
                
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
                    
                SharedProfileModel.commentsProfiles.append(userData)
            }
        }
    }

    dispatchGroup.notify(queue: .main) {
        // 모든 프로필 정보를 가져왔을 때 completion을 호출
        completion(nil)
    }
}

func checkCommentsCount(forPostID postID: String, completion: @escaping (Int?, Error?) -> Void) {
    let database = Firestore.firestore()
    let postDocumentRef = database.collection("posts").document(postID)

    postDocumentRef.getDocument { (document, error) in
        if let error = error {
            completion(nil, error)
            return
        }

        guard let document = document, document.exists else {
            completion(nil, nil)
            return
        }

        if let commentsCount = document.data()?["comments"] as? Int {
            completion(commentsCount, nil)
        } else {
            // 'comments' 필드가 없거나 형식이 맞지 않는 경우
            completion(nil, nil)
        }
    }
}


func fetchFirstTenComments(forPostID postID: String, completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let database = Firestore.firestore()
        let postCommentsRef = database.collection("posts").document(postID).collection("comments")
        
        postCommentsRef.order(by: "date", descending: true).limit(to: 10).getDocuments { (snapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil)
                return
            }
            
            var retrievedComments = [SharedCommentModel]()
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot?.documents ?? [] {
                let comments = SharedCommentModel()
                
                comments.rootID = document.data()["rootID"] as? String
                comments.parentID = document.data()["parentID"] as? String
                comments.commentID = document.data()["commentID"] as? String
                comments.userID = document.data()["userID"] as? String
                comments.content = document.data()["content"] as? String
                comments.date = document.data()["date"] as? String
                comments.location = document.data()["location"] as? String
                comments.like = document.data()["like"] as? [String]
                comments.saved = document.data()["saved"] as? [String]
                comments.shared = document.data()["shared"] as? [Int: String]
                comments.comments = document.data()["comments"] as? Int
                comments.views = document.data()["views"] as? [String] ?? []
                
                if let imageUrls = document.data()["images"] as? [String] {
                    var images = [UIImage]()
                    
                    for imageUrlString in imageUrls {
                        dispatchGroup.enter()
                        
                        loadImage(from: imageUrlString, fallbackImageName: "PlaceholderImage") { (image) in
                            images.append(image)
                            dispatchGroup.leave()
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        comments.images = images
                        retrievedComments.append(comments)
                        
                        if retrievedComments.count == snapshot?.documents.count {
                            SharedCommentModel.comments = retrievedComments
                            
                            // 게시글 작성자의 프로필 정보를 불러오고 배열에 추가
                            fetchProfileInfoForComments(completion: completion)
                        }
                    }
                } else {
                    retrievedComments.append(comments)
                }
            }
        }
    }
}

func uploadRecentSearchesRecord(recentSearchesRecordData: RecentSearchesRecordData, completion: @escaping (SharedRecentSearchesRecordModel?, Error?) -> Void) {
    let db = Firestore.firestore()
    
    if let userID = SharedProfileModel.myProfile.userID {
        // users 컬렉션에 대한 참조
        let userRef = db.collection("users").document(userID)
        let recentSearchesID = generateRandomString(length: 20)
        
        // recentSearchesRecords 컬렉션에 대한 참조
        let recentSearchesRef = userRef.collection("recentSearchesRecords").document(recentSearchesID)
        
        // 문서 데이터
        let data: [String: Any] = [
            "recentSearchesRecordID": recentSearchesID,
            "searchesData": recentSearchesRecordData.searchesData,
            "searchesType": recentSearchesRecordData.searchesType,
            "searchTime": recentSearchesRecordData.searchTime
        ]
        
        let userData = SharedRecentSearchesRecordModel()
        
        userData.recentSearchesRecordID = recentSearchesID
        userData.searchesData = recentSearchesRecordData.searchesData
        userData.searchesType = recentSearchesRecordData.searchesType
        userData.searchTime = recentSearchesRecordData.searchTime
        
        // 1이라는 문서 추가 후 searchesData와 searchesType 필드 추가
        recentSearchesRef.setData(data) { error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(userData, nil)
            }
        }
    }
}

func fetchRecentSearchesRecords(completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    
    if let userID = SharedProfileModel.myProfile.userID {
        let userRef = db.collection("users").document(userID)
        let recentSearchesRef = userRef.collection("recentSearchesRecords")
        
        let dispatchGroup = DispatchGroup()
        
        // 최신순으로 정렬하여 가져오기
        recentSearchesRef.order(by: "searchTime", descending: true).getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                // No documents found, return without error
                completion(nil)
                return
            }
            
            for document in documents {
                dispatchGroup.enter()
                
                guard let recentSearchesRecordID = document["recentSearchesRecordID"] as? String,
                      let searchesData = document["searchesData"] as? String,
                      let searchesType = document["searchesType"] as? String,
                      let searchTime = document["searchTime"] as? String else {
                    continue
                }
                
                let userData = SharedRecentSearchesRecordModel()
                
                userData.recentSearchesRecordID = recentSearchesRecordID
                userData.searchesData = searchesData
                userData.searchesType = searchesType
                userData.searchTime = searchTime
                
                SharedRecentSearchesRecordModel.nomarl.append(userData)
                
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                // 모든 프로필 정보를 가져왔을 때 UI 업데이트 수행
                completion(nil)
            }
        }
    }
}

// 특정 문서 업데이트 함수
func updateRecentSearchesRecord(recentSearchesRecordData: RecentSearchesRecordData, documentID: String, completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    
    if let userID = SharedProfileModel.myProfile.userID {
        // users 컬렉션에 대한 참조
        let userRef = db.collection("users").document(userID)
        
        // recentSearchesRecords 컬렉션에 대한 참조
        let recentSearchesRef = userRef.collection("recentSearchesRecords").document(documentID)
        
        // 업데이트할 데이터
        let data: [String: Any] = [
            "searchesData": recentSearchesRecordData.searchesData,
            "searchesType": recentSearchesRecordData.searchesType,
            "searchTime": recentSearchesRecordData.searchTime
        ]
        
        // 문서 업데이트
        recentSearchesRef.setData(data, merge: true) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}

// 특정 recentSearches 문서 삭제 함수
func deleteRecentSearchesRecord(documentID: String, completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    
    if let userID = SharedProfileModel.myProfile.userID {
        // users 컬렉션에 대한 참조
        let userRef = db.collection("users").document(userID)
        
        // recentSearchesRecords 컬렉션에 대한 참조
        let recentSearchesRef = userRef.collection("recentSearchesRecords").document(documentID)
        
        // 문서 삭제
        recentSearchesRef.delete { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}

// 이 유저 아이디 문서의 모든 recentSearches 컬렉션 삭제하는 함수
func deleteAllRecentSearchesRecords(completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    
    if let userID = SharedProfileModel.myProfile.userID {
        // users 컬렉션에 대한 참조
        let userRef = db.collection("users").document(userID)
        
        // recentSearchesRecords 컬렉션 참조
        let recentSearchesRef = userRef.collection("recentSearchesRecords")
        
        // 모든 문서 삭제
        recentSearchesRef.getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            for document in snapshot?.documents ?? [] {
                document.reference.delete()
            }
            
            completion(nil)
        }
    }
}

func retrievePostsRelatedToSearch(_ searchQuery: String, completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let database = Firestore.firestore()
        let postCollectionRef = database.collection("posts")
        
        // 검색 쿼리와 연관된 내용이 있는 게시물들을 가져옴
        postCollectionRef
            .whereField("content", isGreaterThanOrEqualTo: searchQuery)
            .order(by: "date", descending: true)
            .limit(to: 10)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(error)
                    return
                }
                
                if snapshot?.documents.isEmpty ?? true {
                    // 컬렉션이 비어있는 경우 성공으로 간주
                    completion(nil)
                    return
                }
                
                var retrievedPosts = [SharedPostModel]()
                let dispatchGroup = DispatchGroup()
                
                for document in snapshot?.documents ?? [] {
                    let post = SharedPostModel()
                    post.postID = document.data()["postID"] as? String
                    post.userID = document.data()["userID"] as? String
                    post.content = document.data()["content"] as? String
                    post.date = document.data()["date"] as? String
                    post.location = document.data()["location"] as? String
                    post.like = document.data()["like"] as? [String]
                    post.saved = document.data()["saved"] as? [String]
                    post.shared = document.data()["shared"] as? [Int: String]
                    post.comments = document.data()["comments"] as? Int ?? 0
                    post.views = document.data()["views"] as? [String]
                    
                    if let imageUrls = document.data()["images"] as? [String] {
                        var images = [UIImage]()
                        
                        for imageUrlString in imageUrls {
                            dispatchGroup.enter()
                            
                            loadImage(from: imageUrlString, fallbackImageName: "PlaceholderImage") { (image) in
                                images.append(image)
                                dispatchGroup.leave()
                            }
                        }
                        
                        dispatchGroup.notify(queue: .main) {
                            post.images = images
                            retrievedPosts.append(post)
                            
                            if retrievedPosts.count == snapshot?.documents.count {
                                SharedPostModel.searchPosts = retrievedPosts
                                
                                // 게시글 작성자의 프로필 정보를 불러오고 배열에 추가
                                fetchProfileInfoForSearchesPosts(completion: completion)
                            }
                        }
                    } else {
                        retrievedPosts.append(post)
                    }
                }
            }
    }
}

// 게시글 작성자의 프로필 정보를 불러오는 함수
func fetchProfileInfoForSearchesPosts(completion: @escaping (Error?) -> Void) {
    let dispatchGroup = DispatchGroup()
    var uniqueUserIDs = Set<String>()  // Set을 사용하여 중복된 유저 ID를 방지

    for post in SharedPostModel.searchPosts {
        guard let userID = post.userID, !uniqueUserIDs.contains(userID) else {
            continue  // 이미 추가된 유저 ID면 skip
        }

        dispatchGroup.enter()
        uniqueUserIDs.insert(userID)

        // users 컬렉션에서 userID에 해당하는 문서의 정보를 가져옴
        let userDocRef = Firestore.firestore().collection("users").document(userID)
        userDocRef.getDocument { (document, error) in
            defer { dispatchGroup.leave() }

            if let error = error {
                print("Error fetching user profile:", error.localizedDescription)
                return
            }

            if let document = document, document.exists {
                guard let profileName = document["profileName"] as? String,
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
                      let userID = document["userID"] as? String else {
                    return
                }
                
                
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
                    
                SharedProfileModel.searchPostsProfiles.append(userData)
            }
        }
    }

    dispatchGroup.notify(queue: .main) {
        // 모든 프로필 정보를 가져왔을 때 completion을 호출
        completion(nil)
    }
}
