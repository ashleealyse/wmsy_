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
    ("animals", UIImage(named: "animalsCategoryIcon")),
    ("arts", UIImage(named: "artsCategoryIcon")),
    ("coffee", UIImage(named: "coffeeCategoryIcon")),
    ("drinks", UIImage(named: "drinksCategoryIcon")),
    ("entertainment", UIImage(named: "entertainmentCategoryIcon")),
    ("games", UIImage(named: "gamesCategoryIcon")),
    ("restaurants", UIImage(named: "restaurantsCategoryIcon")),
    ("shopping", UIImage(named: "shoppingCategoryIcon")),
    ("sports", UIImage(named: "sportsCategoryIcon"))]

let hoursOfTwentyFour = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
