//
//  Holidays.swift
//  JsonFetching
//
//  Created by apple on 12/07/20.
//  Copyright © 2020 com.rohit. All rights reserved.
//

import Foundation




struct HolidayResponse:Decodable {
    var response:Holidays
}
struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name:String
    var date:DateInfo
}

struct DateInfo:Decodable {
   var  iso:String
}
