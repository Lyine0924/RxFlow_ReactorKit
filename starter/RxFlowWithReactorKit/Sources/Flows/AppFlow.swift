//
//  AppFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit
import RxFlow
import RxCocoa
import RxSwift

struct AppStepper: Stepper {
	let steps: PublishRelay<Step> = .init()
	private let provider: ServiceProvider
	private let disposeBag: DisposeBag = .init()
	
	init(provider: ServiceProvider) {
		self.provider = provider
	}
	
	func readyToEmitSteps() {
		provider.loginService.didLoginObservable
			.map { $0 ? SampleStep.loginIsCompleted : SampleStep.loginIsRequired }
			.bind(to: steps)
			.disposed(by: self.disposeBag)
	}
}
