//
//  DataManager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit

var myDataList = [UserData]()

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
    var intrduction: String?
    var email: String?
    var phoneNumber: String?
    var image: String?
    var birth: String?
    var gender: String?
    var userID: String?
}

func formatNumber(_ number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 1

    if number >= 1_000_000 {
        let roundedValue = round(Double(number) / 100_000) / 10
        return "\(formatter.string(from: NSNumber(value: roundedValue)) ?? "")M"
    } else if number >= 1_000 {
        let roundedValue = round(Double(number) / 100) / 10
        return "\(formatter.string(from: NSNumber(value: roundedValue)) ?? "")k"
    } else {
        return "\(number)"
    }
}
