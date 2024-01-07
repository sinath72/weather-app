//
//  weatherNetwork.swift
//  weather app
//
//  Created by Sina Taherkhani on 6/8/1400 AP.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import SwiftLocation
import CoreLocation
protocol DataModelDelegate:class{
    func didReciveData(Data:weather)
    func didFildWithError(error:Error)
}
class DataModel {
    weak var delegate:DataModelDelegate?
    func requestData(url:String) {
        self.getGPScoord(completionGps: {location in
            let _:String=AppDelegate.url+"lat=\(location.latitude)&lon=\(location.longitude)&appid=\(AppDelegate.APIKEY)"
        }
        )
        AF.request(URL(string: url)!,method: .get,parameters: nil,encoding: JSONEncoding.default,headers: nil).responseJSON{(response) in
            switch response.result{
            
            case .success(_):
                if let json=try?JSON(response.data!){
                    let weatherData = weather(lat: json["coord"]["lat"].stringValue, long: json["coord"]["lon"].stringValue, main: json["weather"][0]["main"].stringValue, temp: Float(json["main"]["temp"].stringValue)!)
                    self.delegate?.didReciveData(Data: weatherData)
                    
                }
            case .failure(let error):
                self.delegate?.didFildWithError(error: error)
                break
            }
        }
    }
    func getGpsCoord(completion: @escaping (CLLocationCoordinate2D) -> ()) {
        _ = LocationManager.shared.locateFromGPS(.continous, accuracy: .city) {result in
          switch result {
            case .failure(let error):
              debugPrint("Received error: \(error)")
            case .success(let location):
                completion(location.coordinate)
          }
        }

    }
    
}

