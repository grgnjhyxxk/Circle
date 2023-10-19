//
//  DataManager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit

var userDataList = [UserData]()

struct UserData {
    var profileName: String
    var userName: String
    var password: String
    var myCircleDigits: Int
    var inTheCircleDigits: Int
    var feedDigits: Int
    var followerDigits: Int
    var followingDigits: Int
    var socialValidation: Bool
    var intrduction: String?
    var email: String?
    var phoneNumber: String?
    var image: String?
    var birth: String?
    var gender: String?
    var userID: String?
}
