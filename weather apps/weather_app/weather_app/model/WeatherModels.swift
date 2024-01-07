//
//  WeatherModels.swift
//  weather_app
//
//  Created by Sina Taherkhani on 6/11/1400 AP.
//

import Foundation
import UIKit
class weather {
    private let main:String
    private let lat:String
    private let lon:String
    private let temp:Float
    private let description:String
    private let icon:UIImage
    init(main:String,lat:String,long:String,temp:Float,description:String,icon:UIImage) {
        self.lat=lat
        self.lon=long
        self.main=main
        self.temp=temp
        self.description=description
        self.icon=icon
    }
    func getMain() -> String {
        return self.main
    }
    func getLat() -> String {
        return self.lat
    }
    func getlong() -> String {
        return self.lon
    }
    func getTemp() -> Float {
        return self.temp
    }
    func getDescription() -> String {
        return self.description
    }
    func getIcon() -> UIImage {
        return self.icon
    }
}
