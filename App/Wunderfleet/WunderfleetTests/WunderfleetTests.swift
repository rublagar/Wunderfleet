//
//  WunderfleetTests.swift
//  WunderfleetTests
//
//  Created by Ruben Blanco on 11/7/21.
//

import XCTest
@testable import Wunderfleet

import RxSwift
import RxTest
import RxBlocking

class WunderfleetTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Map Tests
    func testCars() throws {
        let mapViewModel = MapViewModel(apiService: MockAPI())

        let cars = try XCTUnwrap(mapViewModel.carsDetailResponse.toBlocking(timeout: 10).first())
        XCTAssertGreaterThan(cars.count, 0)
    }

    // MARK: Car Detail Tests
    func testCarAttributes() throws {
        let carDetailViewModel = CarDetailViewModel(apiService: MockAPI(),
                                                    carId: 1)
        let attributes = try XCTUnwrap(carDetailViewModel.carAttributes.toBlocking(timeout: 10).first())
        XCTAssertGreaterThan(attributes.count, 0)
    }
    
    func testExpectedCar() throws {
        let carId: Int = 1
        let carDetailViewModel = CarDetailViewModel(apiService: MockAPI(),
                                                    carId: carId)
        
        let car = try XCTUnwrap(carDetailViewModel.carsDetailResponse.toBlocking(timeout: 10).first())
        
        XCTAssertEqual(carId, car.carId)
    }

    // MARK: Reservation Test
    func testReservation() throws {
        let carDetailViewModel = CarDetailViewModel(apiService: MockAPI(), carId: 1)

        carDetailViewModel.quickRental()
        
        let reservation = try XCTUnwrap(carDetailViewModel.quickRentalResponse.toBlocking(timeout: 10).first())
        XCTAssertTrue(reservation.reserved)
    }

}
