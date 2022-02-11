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
	
	let rootViewController = UITabBarController()
	
	func navigate(to step: Step) -> FlowContributors {
		return .none
	}
}
