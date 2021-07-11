//
//  CarDetailViewController.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import UIKit

import RxSwift
import Kingfisher

final class CarDetailViewController: BaseViewController {
    
    var viewModel: CarDetailViewModel!
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var quickRentalButton: UIButton!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.subscribeViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.viewModel.dismiss()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        self.hideLoader()
    }
    
    // MARK: Actions
    
    @IBAction func quickRental(_ sender: Any) {
        self.hideLoader(hide: false)
        self.viewModel.quickRental()
    }
    
}

// MARK: ViewModel Subscribers

extension CarDetailViewController {
    // Add Car data to the UI
    private func subscribeViewModel() {
        self.viewModel.carsDetailResponse.subscribe(onNext: { [weak self] car in
            self?.title = car.title
            self?.carImageView.kf.setImage(with: car.imageURL)
        }, onError: { [weak self] _ in
            // Avoid show view with wrong API data
            self?.navigationController?.popViewController(animated: true)
            self?.showAlert(title: "CAR_DATA_FAILED_TITLE".localized,
                            message: "CAR_DATA_FAILED_MESSAGE".localized)
        }, onCompleted: {
            self.hideLoader()
        })
        .disposed(by: self.disposeBag)
        
        // Handle Reservations
        self.viewModel.quickRentalResponse.subscribe(onNext: { [weak self] reservation in
            self?.hideLoader()
            guard reservation.reserved else {
                self?.showAlert(title: "CAR_DETAIL_ALERT_FAILED_TITLE".localized,
                                message: "CAR_DETAIL_ALERT_FAILED_MESSAGE".localized)
                return
            }
            self?.showAlert(title: "CAR_DETAIL_ALERT_SUCCESS_TITLE".localized,
                            message: "CAR_DETAIL_ALERT_SUCCESS_MESSAGE".localized)
        }, onError: { [weak self] _ in
            self?.hideLoader()
        })
        .disposed(by: self.disposeBag)
        
        // Bind Table with Car attributes
        self.viewModel.carAttributes
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CarDetailsCell.identifier,
                                         cellType: CarDetailsCell.self)) { index, element, cell in
            cell.carAttribute = element
            }
            .disposed(by: self.disposeBag)
    }
    
}
