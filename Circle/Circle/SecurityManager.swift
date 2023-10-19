//
//  SecurityManager.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit

func generateRandomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in letters.randomElement()! })
}
