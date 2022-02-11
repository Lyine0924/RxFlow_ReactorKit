//
//  MainFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit

import RxSwift
import RxFlow

final class MainFlow: Flow {
	
	var root: Presentable {
		return self.rootViewController
	}
	
	struct Dependency {
		let provider: ServiceProviderType
	}
	
	let rootViewController = UITabBarController()
	
	private let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func navigate(to step: Step) -> FlowContributors {
		return .none
	}
}
