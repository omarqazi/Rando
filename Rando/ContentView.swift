import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var cameraPosition: MapCameraPosition = .automatic
    var body: some View {
        VStack {
            Map {
                MapPolyline(coordinates: PlayBoundary.coordinates).stroke(.red,lineWidth: 3)
                ForEach(viewModel.annotations) { annotation in
                    Annotation(annotation.title ?? "", coordinate: annotation.coordinate) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                            Text(annotation.title ?? "")
                                .font(.caption)
                            Text(annotation.subtitle ?? "")
                                .font(.caption2)
                        }
                        .onTapGesture {
                            if let title = annotation.title {
                                let coordinate = annotation.coordinate
                                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
                                mapItem.name = "Random Point"
                                
                                MKMapItem.openMaps(with: [mapItem], launchOptions: [:])
                            }
                        }
                    }
                }
            }
            .mapStyle(.standard)
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .edgesIgnoringSafeArea(.all)
            
            Text(viewModel.annotations.first?.title ?? "To generate a random location")
            Text(viewModel.annotations.first?.subtitle ?? "Tap Below")

            Button(action: {
                viewModel.generateRandomPoint()
            }) {
                Text("Generate Random Point")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
