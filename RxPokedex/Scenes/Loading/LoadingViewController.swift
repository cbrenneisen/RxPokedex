//
//  LoadingViewController.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoadingViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = LoadingViewModel()
    var disposeBag = DisposeBag()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    //MARK: - Setup
    func setupBindings(){
        
        viewModel
            .title
            .bind(to: mainLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .loading
            .asDriver(onErrorJustReturn: true)
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func set(loading: Bool){
        viewModel.set(loading: loading)
    }
}
