//
//  MapView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 18/04/25.
//
import SwiftUI
import MapKit

struct MapView: View {
    var places: [PlaceAnnotation]
    @Binding var selectedPlace: PlaceAnnotation?
    @State var position = MapCameraPosition.automatic

    var onClose: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(initialPosition: position) {
                ForEach(places) { place in
                    Annotation(place.name, coordinate: place.coordinate) {
                        Button(action: {
                            selectedPlace = place
                        }, label: {
                            Image(systemName: "figure.racquetball")
                                .foregroundColor(.red)
                                .font(.title)
                        })
                    }
                }
            }

            Button(action: {
                onClose()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding()
            })
            .padding()
        }
        .alert(item: $selectedPlace) { place in
            Alert(title: Text(place.name),
                  message: Text(place.address),
                  primaryButton: .default(Text("Abrir en Mapas"), action: {
                      // Acción para abrir en Apple Maps, si se quiere implementar
                  }),
                  secondaryButton: .default(Text("OK")))
        }
    }
}

