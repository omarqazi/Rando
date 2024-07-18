import Foundation
import CoreLocation
import MapKit

struct PlayBoundary {
    static let coordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 33.8056798, longitude: -118.3893047),
        CLLocationCoordinate2D(latitude: 33.9279781, longitude: -118.4226156),
        CLLocationCoordinate2D(latitude: 33.9265537, longitude: -118.3673264),
        CLLocationCoordinate2D(latitude: 33.8056798, longitude: -118.3340155),
        CLLocationCoordinate2D(latitude: 33.8056798, longitude: -118.3893047),
    ]
    
    static func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let polygon = MKPolygon(coordinates: PlayBoundary.coordinates, count: PlayBoundary.coordinates.count)
        let renderer = MKPolygonRenderer(polygon: polygon)
        
        let mapPoint = MKMapPoint(coordinate)
        let point = renderer.point(for: mapPoint)
        return renderer.path.contains(point)
    }
}
