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
	private let provider: ServiceProviderType
	private let disposeBag: DisposeBag = .init()
	
	init(provider: ServiceProviderType) {
		self.provider = provider
	}
	
	func readyToEmitSteps() {
		provider.loginService.didLoginObservable
			.map { $0 ? SampleStep.loginIsCompleted : SampleStep.loginIsRequired }
			.bind(to: steps)
			.disposed(by: self.disposeBag)
	}
}

final class AppFlow: Flow {
	var root: Presentable {
		return self.rootWindow
	}
	
	private let rootWindow: UIWindow
	private let provider: ServiceProviderType
	
	init(
		with window: UIWindow,
		and provider: ServiceProviderType
	) {
		self.rootWindow = window
		self.provider = provider
	}
	
	deinit {
		print("\(type(of: self)): \(#function)")
	}
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .loginIsRequired:
				return coordinateToLoginVC()
			case .mainTabBarIsRequired, .loginIsCompleted:
				return coordinateToMainVC()
			default:
				return .none
		}
	}
	
	
	private func coordinateToLoginVC() -> FlowContributors {
		return .none
	}
	
	private func coordinateToMainVC() -> FlowContributors {
		return .none
	}
}
