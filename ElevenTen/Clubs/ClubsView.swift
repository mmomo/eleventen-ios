import SwiftUI
import MapKit

struct ClubsView: View {
    @StateObject private var viewModel = ClubsViewModel()
    @State private var selectedPlace: PlaceAnnotation?
    @State private var showingMap = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando clubes...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.racquetballPlaces) { place in
                        HStack {
                            Image(place.imageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)

                            VStack(alignment: .leading) {
                                Text(place.name)
                                    .font(.headline)
                                Text(place.address)
                                    .font(.subheadline)
                            }
                            .padding(.vertical)
                        }
                        .onTapGesture {
                            selectedPlace = place
                        }
                    }

                    Button(action: {
                        showingMap = true
                    }) {
                        Text("Ver Mapa")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.brandButtonBackground)
                            .cornerRadius(10)
                    }
                    .padding()
                    .sheet(isPresented: $showingMap) {
                        MapView(places: viewModel.racquetballPlaces, selectedPlace: $selectedPlace) {
                            showingMap = false
                        }
                    }
                }
            }
            .navigationBarTitle("¿Dónde practicar?", displayMode: .automatic)
            .onAppear {
                viewModel.fetchPlaces()
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
