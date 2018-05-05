//
//  Categories.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit

enum Category: String, Codable {
    case wmsy
    case animals
    case arts
    case coffee
    case drinks
    case entertainment
    case games
    case restaurants
    case shopping
    case sports
    
    static func all() -> [Category] {
        return [.wmsy,
                .animals,
                .arts,
                .coffee,
                .drinks,
                .entertainment,
                .games,
                .restaurants,
                .shopping,
                .sports]
    }
}

let categoryTuples = [
    ("wmsy", UIImage(named: "wmsyCategoryIcon")),
    ("Animals", UIImage(named: "animalsCategoryIcon")),
    ("Arts", UIImage(named: "artsCategoryIcon")),
    ("Coffee", UIImage(named: "coffeeCategoryIcon")),
    ("Drinks", UIImage(named: "drinksCategoryIcon")),
    ("Entertainment", UIImage(named: "entertainmentCategoryIcon")),
    ("Games", UIImage(named: "gamesCategoryIcon")),
    ("Restaurants", UIImage(named: "restaurantsCategoryIcon")),
    ("Shopping", UIImage(named: "shoppingCategoryIcon")),
    ("Sports", UIImage(named: "sportsCategoryIcon"))]

let hoursOfTwentyFour = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
