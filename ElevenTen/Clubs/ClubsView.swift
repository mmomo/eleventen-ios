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
                }, label: {
                    Text("Ver Mapa")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
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
        }
        .alert(item: $selectedPlace) { place in
            Alert(title: Text(place.name),
                  message: Text(place.address),
                  primaryButton: .default(Text("Abrir en Mapas"), action: {
            }),
                  secondaryButton: .default(Text("OK")))
        }
        .navigationTitle("Map")
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
}
