//
//  MapViewController.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import UIKit
import MapKit

import RxSwift

final class MapViewController: BaseViewController {
    
    var viewModel: MapViewModel!
    
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupLocationManager()
        self.setRegion()
        self.subscribeViewModel()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        self.title = "MAP_VIEW_TITLE".localized
        self.hideLoader(hide: false)
        self.mapView.delegate = self
    }
    
}

// MARK: ViewModel Subscribers

extension MapViewController {
    
    private func subscribeViewModel() {
        // Add cars annotations to map
        self.viewModel.carsDetailResponse
            .subscribe(onNext: { [weak self] cars in
            guard let wself = self else { return }
            guard let cars = cars else { return }
            wself.hideLoader()
            let carsAnnotations = cars.compactMap { car in
                CarAnnotation(car)
            }
            wself.mapView.addAnnotations(carsAnnotations)
        })
        .disposed(by: self.disposeBag)
    }
    
}

// MARK: MapView Logic

extension MapViewController: MKMapViewDelegate {
    
    // User location
    private func setupLocationManager() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
    }
    
    // Set focused region to test result
    private func setRegion() {
        let coordinate = CLLocationCoordinate2D(latitude: Constants.latitude,
                                                longitude: Constants.longitude)
        let region = self.mapView.regionThatFits(MKCoordinateRegion(center: coordinate,
                                                                    latitudinalMeters: Constants.latitudinalMeters,
                                                                    longitudinalMeters: Constants.longitudinalMeters))
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Return user annotation
        if annotation is MKUserLocation {
            let userAnnotation = (mapView.view(for: annotation) as? MKPinAnnotationView)
                ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            userAnnotation.image = UIImage(named: Assets.UserLocation)
            return userAnnotation
        }
        
        // Customize and return cars annotations
        let identifier = Constants.annotationId
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        }
        
        if let carAnnotation = annotation as? CarAnnotation {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            titleLabel.text = carAnnotation.carTitle
            annotationView?.detailCalloutAccessoryView = titleLabel
            let anottationButton = UIButton(type: .infoDark)
            anottationButton.setImage(UIImage(named: Assets.Arrow), for: .normal)
            anottationButton.tintColor = .black
            annotationView?.image = UIImage(named: Assets.WunderPOI)
            annotationView?.rightCalloutAccessoryView = anottationButton
        }
        return annotationView
    }
    
    // Handle hide or show annotations feature
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.annotations.forEach { annotation in
            guard !(annotation is MKUserLocation) else {
                return
            }
            mapView.view(for: annotation)?.isHidden = true
        }
        view.isHidden = false
    }
        
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        for annotation in mapView.annotations where !(annotation is MKUserLocation) {
            mapView.annotations.forEach { annotation in
                mapView.view(for: annotation)?.isHidden = false
            }
        }
    }
    
    // Show car detail view
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let car = view.annotation as? CarAnnotation {
            self.viewModel.showCarDetail.accept(car.item)
        }
    }
    
}
