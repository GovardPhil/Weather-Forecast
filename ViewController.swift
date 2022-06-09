//
//  ViewController.swift
//  WeatherForecast
//
//  Created by ПавелК on 15.02.2022.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var currentDegree: UISegmentedControl!
    var weather : CurrentWeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func getTempString (weather : CurrentWeatherData) -> String {
        switch self.currentDegree.selectedSegmentIndex {
        case 0 :
            let celcInt = Int(weather.main["temp"]! - 273)
            let tempString = celcInt > 0 ? "+\(celcInt)" : "\(celcInt)"
            return tempString
        case 1 :
            let celcInt = Int(weather.main["temp"]! - 273)
            let farDegree = celcInt * 2 + 32
            let tempString = farDegree > 0 ? "+\(farDegree)" : "\(farDegree)"
            return tempString
        case 2 :
            let kelGegree  = Int(weather.main["temp"]!)
            let tempString = "\(kelGegree)"
            return tempString
        default : return ""
        }
    }
    func getWindDirection (weather : CurrentWeatherData) -> String {
        var direction = ""
        switch weather.wind["deg"]! {
        case 0..<45 :
            direction = "С"
        case 45..<135 :
            direction = "В"
        case 135..<225 :
            direction = "Ю"
        case 225..<315 :
            direction = "З"
        case 315...360 :
            direction = "С"
        default : break
        }
        return direction
    }
    
    func getCurrentWeather (city : String) -> Void {
        
        NetworkManager.shared.getRequest(city: city) { weather in
            DispatchQueue.main.async {
                self.weather = weather
                self.cityLabel.text = weather.name
                self.tempLabel.text = self.getTempString(weather: weather)
                self.windLabel.text = "\(self.getWindDirection(weather: weather)) \(weather.wind["speed"]!) м/с"
            }
        }
    }
    
    @IBAction func checkWeather(_ sender: UIButton) {
        guard let city = self.cityTextField.text else {return}
        self.getCurrentWeather(city: city)
    }
    
    @IBAction func changeDegree(_ sender: UISegmentedControl) {
        guard let weather = weather else {
            return
        }
        self.tempLabel.text = getTempString(weather: weather)
    }
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell",for: indexPath) as! TableViewCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    
}

