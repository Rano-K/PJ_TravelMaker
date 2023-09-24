//
//  MapViewController.swift
//  TravelMaker
//
//  Created by ms k on 2023/09/22.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mapView = NMFMapView(frame: view.frame)
            view.addSubview(mapView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
