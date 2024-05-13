//
//  RacquetballPlacesModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 01/05/24.
//

import Foundation
import MapKit

struct PlaceAnnotation: Identifiable, Decodable {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let imageUrl: String
    
    // Agregamos una propiedad computada para obtener la coordenada a partir de latitude y longitude
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
