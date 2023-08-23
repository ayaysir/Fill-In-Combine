//
//  Constants.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import UIKit

enum CustomFont: String {
    case musiqwik = "Musiqwik"
    case musiSync = "MusiSync"
    case sevenSegement = "Seven Segment"
    case neoDunggeunmo = "NeoDunggeunmoPro-Regular"
    
    static func viewFontList() {
        for family in UIFont.familyNames {
            print("\(family)")

            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}
