import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var heading: CLHeading?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var addressString: String = "Locating..."
    @Published var speed: CLLocationSpeed = 0.0 // in m/s
    
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        authorizationStatus = manager.authorizationStatus
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startUpdating() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    
    func stopUpdating() {
        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            startUpdating()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation
        
        // speed is returned in m/s, negative if invalid
        if newLocation.speed >= 0 {
            self.speed = newLocation.speed
        } else {
            self.speed = 0.0
        }
        
        // Reverse geocode
        geocoder.reverseGeocodeLocation(newLocation) { [weak self] placemarks, error in
            guard let self = self, error == nil, let placemark = placemarks?.first else {
                return
            }
            
            var components: [String] = []
            if let subThoroughfare = placemark.subThoroughfare { components.append(subThoroughfare) }
            if let thoroughfare = placemark.thoroughfare { components.append(thoroughfare) }
            if let locality = placemark.locality { components.append(locality) }
            if let administrativeArea = placemark.administrativeArea { components.append(administrativeArea) }
            
            if !components.isEmpty {
                self.addressString = components.joined(separator: ", ")
            } else {
                self.addressString = "Unknown Location"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.heading = newHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
