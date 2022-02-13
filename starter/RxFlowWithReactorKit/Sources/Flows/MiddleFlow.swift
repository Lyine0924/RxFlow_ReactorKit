//
//  MiddleFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/14.
//

import UIKit
import RxFlow
import RxRelay

struct MiddleStepper: Stepper {
	var steps: PublishRelay<Step> = .init()
	
	var initialStep: Step {
		return SampleStep.middleIsRequired
	}
}

final class MiddleFlow: Flow {
	// MARK: Property
	
	var root: Presentable {
		return self.rootViewController
	}
	
	private let rootViewController = UINavigationController()
	
	let stepper: MiddleStepper
	
	private let provider: ServiceProviderType
	
	// MARK: Init
	init(
		with services: ServiceProviderType,
		stepper: MiddleStepper
	) {
		self.provider = services
		self.stepper = stepper
	}
	
	deinit {
		print("\(type(of: self)): \(#function)")
	}
	
	// MARK: Navigate
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .middleIsRequired:
				return coordinateToMiddle()
				
			case .middleIsRequiredAgain:
				return coordinateToMiddleFirst()
				
			case .middleDetailIsRequired:
				return presentMiddleDetail()
				
			case let .settingAndAlertIsRequired(msg):
				let step = SampleStep.settingAndAlertIsRequired(message: msg)
				let contributor: FlowContributor = .forwardToParentFlow(withStep: step)
				return .one(flowContributor: contributor)
				
			case .dismiss:
				return dismissVC()
				
			default:
				return .none
		}
	}
}

// MARK: Method

private extension MiddleFlow {
	func coordinateToMiddle() -> FlowContributors {
		let reactor = MiddleReactor(provider: provider)
		let vc = MiddleViewController(with: reactor)
		self.rootViewController.setViewControllers([vc], animated: true)
		return .one(flowContributor: .contribute(withNextPresentable: vc,
																						 withNextStepper: reactor))
	}
	
	func coordinateToMiddleFirst() -> FlowContributors {
		if (self.rootViewController.viewControllers.first as? MiddleViewController) != nil {
			return .none
		} else {
			return coordinateToMiddle()
		}
	}
	
	// TODO: MiddleDetail 화면이 추가되면 구현할 예정이에요.
	func presentMiddleDetail() -> FlowContributors {
		return .none
	}
	
	func dismissVC() -> FlowContributors {
		self.rootViewController.visibleViewController?.dismiss(animated: true)
		return .none
	}
}
