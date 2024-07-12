import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        VStack {
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
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
                        if let title = annotation.title, let subtitle = annotation.subtitle {
                            let coordinate = annotation.coordinate
                            let coord = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coord))
                            mapItem.name = "Random Point"
                            
                            MKMapItem.openMaps(with: [mapItem], launchOptions: [:])
                        }
                    }
                }
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
