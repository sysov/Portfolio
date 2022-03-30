//
//  ViewController.swift
//  СoordinateCalc
//
//  Created by Valera Sysov on 30.03.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabelKilometrs: UILabel!
    @IBOutlet weak var resultLabelMetrs: UILabel!
    @IBOutlet weak var latitudeATextField: UITextField!
    @IBOutlet weak var longitudeATextField: UITextField!
    @IBOutlet weak var longitudeBTextField: UITextField!
    @IBOutlet weak var latitudeBTextField: UITextField!
    var Pi = Double.pi
    let EarthRad = 6372795.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func ResultButton(_ sender: Any) {
        
        let latitudeA = Double(latitudeATextField.text!) ?? 0.0
        let latitudeB = Double(latitudeBTextField.text!) ?? 0.0
        let longitudeA = Double(longitudeATextField.text!) ?? 0.0
        let longitudeB = Double(longitudeBTextField.text!) ?? 0.0
        
        let latitudeAInRadian = latitudeA * Pi / 180
        let longitudeAInRadian = longitudeA * Pi / 180
        let latitudeBInRadian = latitudeB * Pi / 180
        let longitudeBInRadian = longitudeB * Pi / 180
        
        let cosLatitudeA = cos(latitudeAInRadian)
        let cosLatitudeB = cos(latitudeBInRadian)
        let sinLatitudeA = sin(latitudeAInRadian)
        let sinLatitudeB = sin(latitudeBInRadian)
        let delta = longitudeBInRadian - longitudeAInRadian
        let cosDelta = cos(delta)
        let sinDelta = sin(delta)
        
        let y = sqrt(pow(cosLatitudeB * sinDelta, 2.0) + pow(cosLatitudeA * sinLatitudeB - sinLatitudeA * cosLatitudeB * cosDelta, 2.0))
        let x  = sinLatitudeA * sinLatitudeB + cosLatitudeA * cosLatitudeB * cosDelta
        let ad = atan2(y, x)
        
        let distanceMetrs = ad * EarthRad
        let distanceKilometrs = distanceMetrs / 1000
        
        resultLabelMetrs.text = "Distance in meters: \(NSString(format: "%.3f", distanceMetrs))"
        resultLabelKilometrs.text = "Distance in kilometers: \(NSString(format: "%.3f", distanceKilometrs))"
    }
}

