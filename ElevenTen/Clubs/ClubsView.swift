import SwiftUI
import MapKit

struct ClubsView: View {
    @State private var racquetballPlaces = [PlaceAnnotation]()
    @State private var selectedPlace: PlaceAnnotation?
    @State private var showingMap = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.brandLightBackground.ignoresSafeArea()

                VStack(spacing: 16) {
                    List(racquetballPlaces) { place in
                        HStack(spacing: 12) {
                            Image(place.imageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(place.name)
                                    .font(.headline)
                                    .foregroundColor(.brandText)
                                Text(place.address)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                        .listRowBackground(Color.clear)
                        .onTapGesture {
                            // Acción futura
                        }
                    }
                    .listStyle(.plain)
                    .background(Color.clear)

                    Button(action: {
                        showingMap = true
                    }, label: {
                        Text("Ver Mapa")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brandRed)
                            .cornerRadius(12)
                    })
                    .padding(.horizontal)
                    .sheet(isPresented: $showingMap) {
                        MapView(places: racquetballPlaces, selectedPlace: $selectedPlace) {
                            showingMap = false
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("¿Dónde practicar?")
            .onAppear {
                loadPlacesFromJSON()
            }
        }
    }

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
            Map(position: $position) {
                ForEach(places) { place in
                    Annotation(place.name, coordinate: place.coordinate) {
                        Button(action: {
                            selectedPlace = place
                        }) {
                            Image(systemName: "figure.racquetball")
                                .foregroundColor(.red)
                                .font(.title)
                        }
                    }
                }
            }
            .ignoresSafeArea()

            Button(action: {
                onClose()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding()
            }
        }
        .alert(item: $selectedPlace) { place in
            Alert(
                title: Text(place.name),
                message: Text(place.address),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
