//
//  ConstantString.swift
//  Up+
//
//  Created by Dream on 8/22/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import Foundation


let USER_NAME = "USER_NAME"
let USER_ID = "USER_ID"
let USER_PHOTO_URL = "USER_PHOTO_URL"
let USER_LATITUDE = "USER_LATITUDE"
let USER_LONGTITUDE = "USER_LONGTITUDE"

let SCREEN_HEIGHT  = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let IS_IPHONE_5 =  (IS_IPHONE && SCREEN_HEIGHT == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_HEIGHT == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_HEIGHT == 736.0)
let IS_IPHONE_4_OR_LESS  = IS_IPHONE && SCREEN_HEIGHT < 568.0

let KEYBOARD_HEIGHT:CGFloat = (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 224 : (IS_IPHONE_6 ? 225 : 236)
