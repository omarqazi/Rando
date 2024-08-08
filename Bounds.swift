import Foundation
import CoreLocation
import MapKit

struct PlayBoundary {
    static let coordinates: [CLLocationCoordinate2D] = [
        // South Bay LA:
        //CLLocationCoordinate2D(latitude: 33.8056798, longitude: -118.3893047),
        //CLLocationCoordinate2D(latitude: 33.9279781, longitude: -118.4226156),
        //CLLocationCoordinate2D(latitude: 33.9265537, longitude: -118.3673264),
        //CLLocationCoordinate2D(latitude: 33.8056798, longitude: -118.3340155),
        //CLLocationCoordinate2D(latitude: 33.8056798, longitude: -118.3893047),
        
         CLLocationCoordinate2D(latitude: 37.812, longitude: -122.524),
         CLLocationCoordinate2D(latitude: 37.704, longitude: -122.524),
         CLLocationCoordinate2D(latitude: 37.704, longitude: -122.356),
         CLLocationCoordinate2D(latitude: 37.812, longitude: -122.356),
         CLLocationCoordinate2D(latitude: 37.812, longitude: -122.524),
    ]
    
    static func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let polygon = MKPolygon(coordinates: PlayBoundary.coordinates, count: PlayBoundary.coordinates.count)
        let renderer = MKPolygonRenderer(polygon: polygon)
        
        let mapPoint = MKMapPoint(coordinate)
        let point = renderer.point(for: mapPoint)
        return renderer.path.contains(point)
    }
}
