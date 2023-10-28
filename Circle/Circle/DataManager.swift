//
//  DataManager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit
import SDWebImage

struct UserData {
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

class SharedProfileModel {
    static var myProfile = SharedProfileModel()
    static var otherUsersProfiles = [SharedProfileModel]()

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


