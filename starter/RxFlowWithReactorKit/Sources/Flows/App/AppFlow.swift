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
		return self.rootWindow!
	}
	
	private let dependency: AppFlowComponent
	
	private var rootWindow: UIWindow?
	
	init(
		dependency: AppFlowComponent
	) {
		self.dependency = dependency
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
		let loginFlow = self.dependency.loginBuidler.flow
		
		Flows.use(loginFlow, when: .created) { [unowned self] root in
			self.rootWindow?.rootViewController = root
		}
		
		let nextStep = OneStepper(withSingleStep: SampleStep.loginIsRequired)
		
		return .one(flowContributor: .contribute(withNextPresentable: loginFlow,
																						 withNextStepper: nextStep))
	}
	
	private func coordinateToMainVC() -> FlowContributors {
		let mainFlow = self.dependency.mainBuilder.flow
		
		Flows.use(mainFlow, when: .created) { [unowned self] root in
			self.rootWindow?.rootViewController = root
		}
		
		let nextStep = OneStepper(withSingleStep: SampleStep.mainTabBarIsRequired)
		
		return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: nextStep))
	}
	
	func launch(from: UIWindow) {
		self.rootWindow = from
		self.rootWindow?.makeKeyAndVisible()
	}
}
