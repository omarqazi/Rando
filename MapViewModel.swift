import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Published var annotations: [IdentifiableAnnotation] = []
    @Published var boundaryPolyline: MKPolyline?
    private var geocoder = CLGeocoder()

    init() {
        createBoundaryPolyline()
    }

    func generateRandomPoint() {
        // Define the range for latitude and longitude for Los Angeles land area
        //let latRange = (min: 33.8056798, max: 33.9279781)
        //let lonRange = (min: -118.4226156, max: -118.3340155)
        
        // Define the range for latitude and longitude for the San Francisco area
        let latRange = (min: 37.704, max: 37.812)
        let lonRange = (min: -122.524, max: -122.356)
        
        var randomLat: Double
        var randomLon: Double
        var coordinate: CLLocationCoordinate2D
        
        repeat {
            randomLat = Double.random(in: latRange.min...latRange.max)
            randomLon = Double.random(in: lonRange.min...lonRange.max)
            coordinate = CLLocationCoordinate2D(latitude: randomLat, longitude: randomLon)
        } while !PlayBoundary.contains(coordinate: coordinate)

        // Reverse geocode the coordinates
        reverseGeocodeCoordinates(latitude: randomLat, longitude: randomLon) { address in
            let annotation = IdentifiableAnnotation(
                coordinate: coordinate,
                title: "\(randomLat), \(randomLon)",
                subtitle: address
            )
            DispatchQueue.main.async {
                self.annotations = [annotation]
            }
        }
    }

    private func reverseGeocodeCoordinates(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil)
            } else if let placemarks = placemarks, let placemark = placemarks.first {
                var address = ""
                if let name = placemark.name {
                    address += name + ", "
                }
                if let locality = placemark.locality {
                    address += locality + ", "
                }
                if let country = placemark.country {
                    address += country
                }
                completion(address)
            } else {
                completion(nil)
            }
        }
    }

    private func createBoundaryPolyline() {
        let coordinates = PlayBoundary.coordinates + [PlayBoundary.coordinates.first!]
        boundaryPolyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
    }
}
