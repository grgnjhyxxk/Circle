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

func uploadPostData(postData: PostData, images: [UIImage], userID: String, completion: @escaping (Result<Void, Error>) -> Void) {    
    uploadImages(field: "posts", images: images, userID: userID) { result in
        switch result {
        case .success(let uploadedImageURLs):
            let dataBase = Firestore.firestore()
            let userCollectionRef = dataBase.collection("users").document(userID).collection("posts")
            let postID = generateRandomString(length: 20)
            
            let postCollectionRef = dataBase.collection("posts")

            var data: [String: Any] = [
                "postID": postID,
                "userID": postData.userID,
                "content": postData.content,
                "date": postData.date,
                "location": postData.location,
                "like": postData.like ?? [],
                "saved": postData.saved ?? [],
                "shared": postData.shared ?? [],
                "views": postData.views ?? [],
                "images": uploadedImageURLs // Add image URLs to the post data
            ]
            
            userCollectionRef.document(postID).setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    completion(.success(()))
                    print("Document added successfully")
                }
            }
            
            postCollectionRef.document(postID).setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    completion(.success(()))
                    print("Document added successfully")
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
                "userID": updatedPostData.userID,
                "content": updatedPostData.content,
                "date": updatedPostData.date,
                "location": updatedPostData.location,
                "like": updatedPostData.like ?? [],
                "saved": updatedPostData.saved ?? [],
                "shared": updatedPostData.shared ?? [],
                "views": updatedPostData.views ?? [],
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

// 첫 번째 함수: 처음 4개의 게시글을 불러오는 함수
func retrieveFirstFourPosts(completion: @escaping (Error?) -> Void) {
    DispatchQueue.global().async {
        let database = Firestore.firestore()
        let postCollectionRef = database.collection("posts")
        
        // 추가: 날짜 기준으로 정렬
        postCollectionRef.order(by: "date", descending: true).limit(to: 4).getDocuments { snapshot, error in
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
                post.comments = document.data()["comments"] as? [[[String: String]]]
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
        postCollectionRef.order(by: "date", descending: true).start(after: [lastDate]).limit(to: 4).getDocuments { snapshot, error in
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
                post.comments = document.data()["comments"] as? [[[String: String]]]
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
                    
                SharedProfileModel.postsProfile.append(userData)
                print(SharedProfileModel.postsProfile)
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
                post.comments = document.data()["comments"] as? [[[String: String]]]
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
                            SharedPostModel.myPosts = retrievedPosts
                            print("\(SharedPostModel.myPosts)")
                            completion(nil)
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

