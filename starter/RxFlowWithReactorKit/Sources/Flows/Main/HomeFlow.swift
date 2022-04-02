//
//  HomeFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit

import RxFlow
import RxRelay

struct HomeStepper: Stepper {
	let steps: PublishRelay<Step> = .init()
	
	var initialStep: Step {
		return SampleStep.homeIsRequired
	}
	
	func readyToEmitSteps() {
		debugPrint(self)
	}
}

final class HomeFlow: Flow {
	
	// MARK: Property
	
	var root: Presentable {
		return self.rootViewController
	}
	
	let stepper: HomeStepper
	private let rootViewController = UINavigationController()
	
	private let dependency: HomeFlowComponenet
	
		// MARK: Init
	
	init(
		dependency: HomeFlowComponenet,
		stepper: HomeStepper
	) {
		self.dependency = dependency
		self.stepper = stepper
	}
	
	deinit {
		print("\(type(of: self)): \(#function)")
	}
	
		// MARK: Navigate
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .homeIsRequired:
				return coordinateToHome()
			case .middleIsRequiredAgain:
				return .one(flowContributor: .forwardToParentFlow(withStep: SampleStep.middleIsRequiredAgain))
			case .homeItemIsPicked(let movieID):
				return coordinateToHomeDetail(with: movieID)
			default:
				return .none
		}
	}
}

	// MARK: - Extensions

private extension HomeFlow {
	func coordinateToHome() -> FlowContributors {
		let viewController = self.dependency.homeBuilder.homeViewController
		
		self.rootViewController.setViewControllers([viewController], animated: true)
		
		return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.reactor!))
	}
	
	func coordinateToHomeDetail(with ID: String) -> FlowContributors {
		let viewController = self.dependency.homeDetailBuilder.makeDetailViewController(title: ID)
		self.rootViewController.pushViewController(viewController, animated: true)
		return .one(flowContributor: .contribute(withNextPresentable: viewController,
																						 withNextStepper: viewController.reactor!))
	}
}
