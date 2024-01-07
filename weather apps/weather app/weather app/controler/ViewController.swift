//
//  ViewController.swift
//  weather app
//
//  Created by Sina Taherkhani on 6/8/1400 AP.
//

import UIKit
import SwiftyJSON
import SwiftLocation
class ViewController: UIViewController {

    private let dataSource = DataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource.delegate=self
    }
    override func viewWillAppear(_ animated: Bool) {
        dataSource.requestData(url:AppDelegate.url + "lat=-122.08&lon=37.39&appid=\(AppDelegate.APIKEY)")
        self.getNameWithCompletion {(name) in print("name=\(name)")}
    }
   

}
extension ViewController:DataModelDelegate{
    func didFildWithError(error: Error) {
        print("error:\(error.localizedDescription)")
    }
    
    func didReciveData(Data: weather) {
        print(Data.getWeatherMain())
    }
    
    func getNameWithCompletion(completion: (String)->())
    {
        completion("sina")
    }
}
