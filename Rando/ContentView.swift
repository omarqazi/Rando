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
                            print("\(title) - \(subtitle)")
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)

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
