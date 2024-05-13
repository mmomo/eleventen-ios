import SwiftUI
import MapKit

struct ClubsView: View {
    @State private var racquetballPlaces = [PlaceAnnotation]()
    @State private var selectedPlace: PlaceAnnotation?
    @State private var showingMap = false

    var body: some View {
        NavigationView {
            VStack {
                List(racquetballPlaces) { place in
                    HStack {
                        Image(place.imageUrl) //
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50) // Ajusta el tamaño de la imagen según sea necesario.
                        
                        VStack(alignment: .leading) {
                            Text(place.name)
                                .font(.headline)
                            Text(place.address)
                                .font(.subheadline)
                        }
                        .padding(.vertical)
                    }
                    .onTapGesture {
                        
                    }
                }

                
                Button(action: {
                    showingMap = true
                }) {
                    Text("Ver Mapa")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showingMap) {
                               MapView(places: racquetballPlaces, selectedPlace: $selectedPlace) {
                                           showingMap = false // Close the sheet
                                       }
                           }
                       }
            .navigationBarTitle(Text("¿Dónde practicar?"), displayMode: .inline)
            .onAppear {
                loadPlacesFromJSON()
            }
        }
    }
    
    // Function to load racquetball places from JSON
    func loadPlacesFromJSON() {
        if let url = Bundle.main.url(forResource: "places", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                racquetballPlaces = try decoder.decode([PlaceAnnotation].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

struct MapView: View {
    var places: [PlaceAnnotation]
    @Binding var selectedPlace: PlaceAnnotation?
    @State private var region = MKCoordinateRegion()
    var onClose: () -> Void // Closure to dismiss the modal
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $region, annotationItems: places) { place in
                MapAnnotation(coordinate: place.coordinate) {
                    Button(action: {
                        selectedPlace = place
                    }) {
                        Image(systemName: "figure.racquetball")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
            }
            .alert(item: $selectedPlace) { place in
                Alert(title: Text(place.name),
                      message: Text(place.address),
                      primaryButton: .default(Text("Abrir en Mapas"), action: {
                    // Código para abrir en Mapas
                }),
                      secondaryButton: .default(Text("OK")))
            }
            .onAppear {
                region = regionForAllPlaces()
            }
            .navigationTitle("Map")
            Button(action: {
                onClose()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding()
            }
            .padding()
        }
    }
        
        
        private func regionForAllPlaces() -> MKCoordinateRegion {
            guard let firstPlace = places.first else {
                return MKCoordinateRegion()
            }
            
            var minLatitude = firstPlace.coordinate.latitude
            var maxLatitude = firstPlace.coordinate.latitude
            var minLongitude = firstPlace.coordinate.longitude
            var maxLongitude = firstPlace.coordinate.longitude
            
            for place in places {
                minLatitude = min(minLatitude, place.coordinate.latitude)
                maxLatitude = max(maxLatitude, place.coordinate.latitude)
                minLongitude = min(minLongitude, place.coordinate.longitude)
                maxLongitude = max(maxLongitude, place.coordinate.longitude)
            }
            
            let center = CLLocationCoordinate2D(latitude: (minLatitude + maxLatitude) / 2, longitude: (minLongitude + maxLongitude) / 2)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            return MKCoordinateRegion(center: center, span: span)
        }
    }

