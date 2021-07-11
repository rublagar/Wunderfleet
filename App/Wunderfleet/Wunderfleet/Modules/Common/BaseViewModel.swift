//
//  BaseViewModel.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    let alertDialog = PublishSubject<(String,String)>()
    
}
