import CoreLocation

class LocationData {
    
    let location:CLLocation
    
    init(location:CLLocation) {
        self.location = location
    }
    
    func getLat() -> Double {
        return location.coordinate.latitude
    }
    
    func getLng() -> Double {
        return location.coordinate.longitude
    }
    
}