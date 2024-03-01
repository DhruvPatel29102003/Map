//
//  CustomAnnotation.swift
//  AddPin
//
//  Created by Droadmin on 06/10/23.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var imageName: String // This will hold the image name for the pin

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, imageName: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }
}
