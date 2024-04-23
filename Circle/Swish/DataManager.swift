//
//  DataManager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit
import SDWebImage

class ViewControllerTracker {
    static var myProfileViewController = ViewControllerTracker()
    static var mainViewController = ViewControllerTracker()

    var state: Bool = false
}

struct UserData {
    var signDate: String
    var profileName: String
    var userName: String
    var password: String
    var myCircleDigits: Int
    var myInTheCircleDigits: Int
    var myPostDigits: Int
    var followerDigits: Int
    var followingDigits: Int
    var socialValidation: Bool
    var backgroundImage: String?
    var profileImage: String?
    var userCategory: String?
    var introduction: String?
    var email: String?
    var phoneNumber: String?
    var birth: String?
    var gender: String?
    var userID: String?
}

struct PostData {
    var postID: String?
    var userID: String
    var content: String
    var date: String
    var location: String
    var images: [UIImage]?
    var like: [String]?
    var saved: [String]?
    var shared: [Int: String]?
    var comments: Int?
    var views: [String]?
}

struct CommentData {
    var rootID: String?
    var parentID: String?
    var commentID: String?
    var userID: String
    var content: String
    var date: String
    var location: String
    var images: [UIImage]?
    var like: [String]?
    var saved: [String]?
    var shared: [Int: String]?
    var comments: Int?
    var views: [String]?
}

struct RecentSearchesRecordData {
    var recentSearchesRecordID: String?
    var searchesData: String
    var searchesType: String
    var searchTime: String
}

class SharedRecentSearchesRecordModel {
    static var nomarl = [SharedRecentSearchesRecordModel]()
    
    var recentSearchesRecordID: String?
    var searchesData: String?
    var searchesType: String?
    var searchTime: String?
}

class SharedProfileModel {
    static var myProfile = SharedProfileModel()
    
    static var searchUsersProfiles = [SharedProfileModel]()
    
    static var postsProfiles = [SharedProfileModel]()
    static var commentsProfiles = [SharedProfileModel]()
    static var searchPostsProfiles = [SharedProfileModel]()
    
    static var likeUserProfilesForPost = [SharedProfileModel]()
    static var likeUserProfilesForComment = [SharedProfileModel]()
    static var recommendationsProfiles = [SharedProfileModel]()
    static var recentSearchesRecordProfiles = [SharedProfileModel]()
    
    var signDate: String?
    var profileName: String?
    var userName: String?
    var password: String?
    var myCircleDigits: Int?
    var myInTheCircleDigits: Int?
    var myPostDigits: Int?
    var followerDigits: Int?
    var followingDigits: Int?
    var socialValidation: Bool?
    var backgroundImage: UIImage?
    var profileImage: UIImage?
    var userCategory: String?
    var introduction: String?
    var email: String?
    var phoneNumber: String?
    var birth: String?
    var gender: String?
    var userID: String?

    init() {}
}

class SharedPostModel {
    static var myPosts = [SharedPostModel]()
    static var searchUserPosts = [SharedPostModel]()
    static var othersPosts = [SharedPostModel]()
    static var searchPosts = [SharedPostModel]()

    var postID: String?
    var userID: String?
    var content: String?
    var date: String?
    var location: String?
    var images: [UIImage]?
    var like: [String]?
    var saved: [String]?
    var shared: [Int: String]?
    var comments: Int?
    var views: [String]?
    
    init() {}
}

class SharedCommentModel {
    static var comments = [SharedCommentModel]()

    var rootID: String?
    var parentID: String?
    var commentID: String?
    var userID: String?
    var content: String?
    var date: String?
    var location: String?
    var images: [UIImage]?
    var like: [String]?
    var saved: [String]?
    var shared: [Int: String]?
    var comments: Int?
    var views: [String]?
    
    init() {}
}

func formatNumber(_ number: Int) -> String {
    if number <= 9999 {
        return String(number)
    } else if number >= 10000 && number <= 9999999 {
        let firstThreeDigits = String(number / 1000)
        let fourthDigit = number % 1000 / 100
        
        if fourthDigit == 0 {
            return firstThreeDigits + "만"
        } else {
            return firstThreeDigits + "." + String(fourthDigit) + "만"
        }
    } else if number >= 10000000 && number <= 99999999 {
        let firstDigit = String(number / 10000000)
        let remainingDigits = String(number % 10000000 / 10000)
        return firstDigit + "," + remainingDigits + "만"
    } else {
        return "숫자 범위를 벗어났습니다."
    }
}

func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}

func loadImage(from urlString: String?, fallbackImageName: String, completion: @escaping (UIImage) -> Void) {
    if let urlString = urlString, !urlString.isEmpty, let url = URL(string: urlString) {
        let cacheKey = SDWebImageManager.shared.cacheKey(for: url)
        
        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        SDWebImageDownloader.shared.downloadImage(with: url, options: [], progress: nil) { (image, data, error, finished) in
            if let image = image {
                SDImageCache.shared.store(image, forKey: cacheKey, completion: nil)
                completion(image)
            }
        }
    } else {
        let fallbackImage = UIImage(named: fallbackImageName) ?? UIImage()
        completion(fallbackImage)
    }
}

func currentDateTimeString() -> String {
    let currentDate = Date()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return dateFormatter.string(from: currentDate)
}

func formatPostTimestamp(_ timestamp: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")

    guard let postDate = dateFormatter.date(from: timestamp) else {
        return "Invalid Date"
    }

    let currentDate = Date()
    let calendar = Calendar.current

    let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfMonth, .month, .year], from: postDate, to: currentDate)

    if let years = components.year, years > 0 {
        return "\(years)년 전"
    } else if let months = components.month, months > 0 {
        return "\(months)달 전"
    } else if let weeks = components.weekOfMonth, weeks > 0 {
        return "\(weeks)주 전"
    } else if let days = components.day, days > 0 {
        return "\(days)일 전"
    } else if let hours = components.hour, hours > 0 {
        return "\(hours)시간 전"
    } else if let minutes = components.minute, minutes > 0 {
        return "\(minutes)분 전"
    } else if let seconds = components.second, seconds > 0 {
        return "\(seconds)초 전"
    } else {
        return "방금 전"
    }
}
