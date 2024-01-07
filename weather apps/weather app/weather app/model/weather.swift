//
//  weather.swift
//  weather app
//
//  Created by Sina Taherkhani on 6/8/1400 AP.
//

import Foundation
class weather {
   private let latitute:String
   private let longhitute:String
   private let main:String
   private let temp:Float
    init(lat:String,long:String,main:String,temp:Float) {
        self.latitute=lat
        self.longhitute=long
        self.main=main
        self.temp=temp
    }
    func getWeatherLatitute() -> String {
        return self.latitute
    }
    func getWeatherLonghitute() -> String {
        return self.longhitute
    }
    func getWeatherMain() -> String {
        return self.main
    }
    func getWeatherTemp() -> Float {
        return self.temp
    }
}
