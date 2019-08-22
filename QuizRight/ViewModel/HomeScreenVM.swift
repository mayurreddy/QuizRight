//
//  HomeScreenVM.swift
//  QuizRight
//
//  Created by Mayur on 8/22/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
//

import Foundation
import RxSwift
import GameKit

class HomeScreenVM {
    let isGKPlayerAuthenticated = BehaviorSubject<Bool>(value: false)
    let loginToGameCenterVC = PublishSubject<(UIViewController?, Error?)>()
    
    func checkAuthentication() {
        isGKPlayerAuthenticated.onNext(GKLocalPlayer.local.isAuthenticated)
    }
    
    func attemptAuthentication() {
        let localGKPlayer = GKLocalPlayer.local
        localGKPlayer.authenticateHandler = { loginVC, error in
            if let vc = loginVC {
                self.loginToGameCenterVC.onNext((vc, error))
            } else if let err = error {
                self.loginToGameCenterVC.onNext((nil, err))
            } else {
                print("something else happened")
            }
        }
    }
}
