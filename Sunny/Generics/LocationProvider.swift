import Foundation
import CoreLocation
import RxSwift

protocol LocationProvider {
    var currentLocation: Observable<Location> { get }
}

protocol LocationManager {
    var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: Double { get set }
    var distanceFilter: Double { get set }

    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
}

extension CLLocationManager: LocationManager { }

class MainLocationProvider: NSObject, LocationProvider, CLLocationManagerDelegate {

    var currentLocation: Observable<Location> {
        locationManager.requestWhenInUseAuthorization()
        return currentLocationSubject.asObservable()
    }

    private let currentLocationSubject = PublishSubject<Location>()
    private var locationManager: LocationManager

    init(locationManager: LocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 100
    }

    //MARK: CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            currentLocationSubject.onError(RxError.noElements)
            return
        }
        let coordinatesString = "\(location.coordinate.latitude) \(location.coordinate.longitude)"
        currentLocationSubject.onNext(coordinatesString)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocationSubject.onError(error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}
