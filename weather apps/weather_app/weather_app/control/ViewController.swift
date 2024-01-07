//
//  ViewController.swift
//  weather_app
//
//  Created by Sina Taherkhani on 6/11/1400 AP.
//

import UIKit

private let dataSource = DataModel()

class ViewController: UIViewController {
    @IBOutlet var lbl_status: UILabel!
    @IBOutlet var image_weather: UIImageView!
    @IBOutlet var refresh_btn: UIButton!
    @IBOutlet var loading_spinner: UIActivityIndicatorView!
    
    func loadWeather(){
        self.loading_spinner.isHidden=false
        self.loading_spinner.startAnimating()
        if #available(iOS 13.0, *) {
            dataSource.requestData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate=self
        self.loading_spinner.isHidden=true
        self.refresh_btn.layer.cornerRadius=self.refresh_btn.frame.height / 8
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadWeather()
    }
    @IBAction func refresh_weather(_ sender: Any) {
        loadWeather()
    }
}
extension ViewController: DataModelDelegate{
    func didFildWithError(error: Error) {
        print("error:\(error.localizedDescription)")
    }
    
    func didReciveData(data: weather) {
        print(data.getMain())
        self.image_weather.image=data.getIcon()
        self.lbl_status.text="امروز \(data.getDescription())"
        self.loading_spinner.isHidden=true
        self.loading_spinner.stopAnimating()
    }
    
    func getNameWithCompletion(completion: (String)->())
    {
        completion("sina")
    }
}

