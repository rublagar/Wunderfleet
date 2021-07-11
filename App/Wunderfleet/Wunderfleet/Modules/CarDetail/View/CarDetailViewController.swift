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
        
        self.viewModel.dismissCarDetailView.accept(true)
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
            guard let wself = self else { return }
            guard let car = car else { return }
            wself.hideLoader()
            wself.title = car.title
            wself.carImageView.kf.setImage(with: car.imageURL)
        })
        .disposed(by: self.disposeBag)
        
        // Handle Reservations
        self.viewModel.quickRentalResponse.subscribe(onNext: { [weak self] reservation in
            guard let wself = self else { return }
            guard let reservation = reservation else { return }
            wself.hideLoader()
            guard reservation.reserved else {
                wself.showAlert(title: "CAR_DETAIL_ALERT_FAILED_TITLE".localized,
                                message: "CAR_DETAIL_ALERT_FAILED_MESSAGE".localized)
                return
            }
            wself.showAlert(title: "CAR_DETAIL_ALERT_SUCCESS_TITLE".localized,
                            message: "CAR_DETAIL_ALERT_SUCCESS_MESSAGE".localized)
        })
        .disposed(by: self.disposeBag)
        
        // Bind Table with Car attributes
        _ = self.viewModel.carAttributes
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CarDetailsCell.identifier,
                                         cellType: CarDetailsCell.self)) { index, element, cell in
            cell.carAttribute = element
        }
    }
    
}
