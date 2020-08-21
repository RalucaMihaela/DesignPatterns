import MapKit
import YelpAPI

public class ViewController: UIViewController {
  
  // MARK: - Properties

  // MARK: AdapterPattern
  public var client: BusinessSearchClient = YLPClient(apiKey: YelpAPIKey)
  private var businesses: [Bussiness] = []
  
  // MARK: FactoryPattern
  public let annotationFactory = AnnotationFactory()
  
  private let locationManager = CLLocationManager()
  
  // MARK: - Outlets
  
  @IBOutlet public var mapView: MKMapView! {
    didSet {
      mapView.showsUserLocation = true
    }
  }
  
  // MARK: - View Lifecycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.requestWhenInUseAuthorization()
  }
  
  // MARK: - Actions
  @IBAction func businessFilterToggleChanged(_ sender: UISwitch) {
    
  }
}

// MARK: - MKMapViewDelegate
extension ViewController: MKMapViewDelegate {
  
  public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    centerMap(on: userLocation.coordinate)
  }
  
  private func centerMap(on coordinate: CLLocationCoordinate2D) {
    let regionRadius: CLLocationDistance = 3000
    let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
    searchForBusinesses()
  }
  
  private func searchForBusinesses() {
    let coordinate = mapView.userLocation.coordinate
    guard coordinate.latitude != 0, coordinate.longitude != 0 else {
        return
    }
    
    let yelpCoordinate = YLPCoordinate(latitude: coordinate.latitude,
                                       longitude: coordinate.longitude)
    
    client.search(
      with: mapView.userLocation.coordinate,
      term: "coffee",
      limit: 35, offset: 0,
      success: { [weak self] businesses in
        guard let self = self else { return }

        self.businesses = businesses
        DispatchQueue.main.async {
          self.addAnnotations()
        }
      }, failure: { error in
        print("Search failed: \(String(describing: error))")
      })
  }
  
  // MARK: - FactoryPattern
  
  private func addAnnotations() {
    for business in businesses {
      let viewModel = anotationFactory.createBusinessMapViewModel(for: business)
      mapView.addAnnotation(viewModel)
    }
  }
  
  public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let viewModel = annotation as? BusinessMapViewModel else {
      return nil
    }
    
    let identifier = "business"
    let annotationView: MKAnnotationView
    
    if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
      annotationView = existingView
    } else {
      annotationView = MKAnnotationView(annotation: viewModel, reuseIdentifier: identifier)
    }
    
    annotationView.image = viewModel.image
    annotationView.canShowCallout = true
    
    return annotationView
  }
}
