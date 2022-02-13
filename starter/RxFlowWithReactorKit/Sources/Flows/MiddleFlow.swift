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
	var steps: PublishRelay<Step>
	
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
		return .none
	}
}
