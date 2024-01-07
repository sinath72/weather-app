//
//  weatherNetwork.swift
//  weather_app
//
//  Created by Sina Taherkhani on 6/11/1400 AP.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import SwiftLocation
import CoreLocation
import AlamofireImage
protocol DataModelDelegate:AnyObject {
    func didReciveData(data:weather)
    func didFildWithError(error:Error)
}
class DataModel{
    weak var delegate:DataModelDelegate?
    @available(iOS 13.0, *)
    func requestData(){
        var weatherDesc:weatherImage!
        self.getGpsCoord { (location) in
          //  print("location=\(location)")
            let url:String=AppDelegate.url+"lat=\(location.latitude)&lon=\(location.longitude)&appid=\(AppDelegate.APIKEY)"
            AF.request(URL(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{(response) in
                switch response.result {
                case .success(_):
                    if let json = try? JSON(data:response.data!){
                    self.getWeatherImage(imgUrl: AppDelegate.imageURL+"\(json["weather"][0]["icon"].stringValue)@2x.png"){(myimag) in
                        switch json["weather"][0]["description"].stringValue.replacingOccurrences(of:" ",with:""){
                        case "clearsky":
                            weatherDesc = .clearsky
                            break
                        case "fewclouds":
                            weatherDesc = .fewclouds
                            break
                        case "scatteredclouds":
                            weatherDesc = .scatteredclouds
                            break
                        case "brokenclouds":
                            weatherDesc = .brokenclouds
                            break
                        case "showerrain":
                            weatherDesc = .showerrain
                            break
                        case "rain":
                            weatherDesc = .rain
                            break
                        case "thunderstorm":
                            weatherDesc = .thunderstorm
                            break
                        case "snow":
                            weatherDesc = .snow
                            break
                        case "mist":
                            weatherDesc = .mist
                            break
                        default:
                            weatherDesc = .clearsky
                            break
                        }
                        let weatherData = weather(main: json["weather"][0]["main"].stringValue, lat: json["coord"]["lat"].stringValue, long: json["coord"]["lon"].stringValue, temp: Float(json["main"]["temp"].stringValue)!, description: String(weatherDesc.rawValue), icon:myimag)
                        self.delegate?.didReciveData(data: weatherData)
                    }
                }
                case .failure(let error):
                    self.delegate?.didFildWithError(error: error)
                    break
                }
        }
    }
}
    func getGpsCoord(completion: @escaping (CLLocationCoordinate2D) -> ()) {
     //   var cord:CLLocationCoordinate2D!
        _ = LocationManager.shared.locateFromGPS(.continous, accuracy: .city){
            result in
            switch result {
            case .success(let location):
                completion(location.coordinate)
                break
            case .failure(let error):
                debugPrint("request error:\(error)")
            }
            
        }
    }
    func getWeatherImage(imgUrl:String,completion:@escaping  (UIImage) -> ()){
        AF.request(imgUrl).responseImage{ (response) in
            
            if case .success (let image) = response.result{
                completion(image)
            }
        }
    }
}
