//
//  AppCoordinator.swift
//  MoneyExcangeCalculator
//
//  Created by johnson veerlapally on 09/12/24.
//


import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
         // The first time this coordinator started, is to launch login page.
    goToLoginPage()
    }
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    func goToLoginPage(){
        
    }
    
    func goToRegisterPage(){
        
    }
}
