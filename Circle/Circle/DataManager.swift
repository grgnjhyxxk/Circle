//
//  DataManager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit

var myDataList = [UserData]()
var searchUserList = [SearchResult]()

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

struct SearchResult {
    var profileName: String
    var profileImage: String?
    var userName: String
    var socialValidation: Bool
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
