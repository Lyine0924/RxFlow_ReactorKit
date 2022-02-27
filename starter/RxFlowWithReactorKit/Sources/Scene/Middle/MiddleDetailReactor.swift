//
//  MiddleDetailReactor.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/02/27.
//

import Foundation
import RxFlow
import RxCocoa
import ReactorKit

final class MiddleDetailReactor: Reactor, Stepper {
	
		// MARK: Stepper
	
	var steps: PublishRelay<Step> = .init()
	
		// MARK: Events
	
	enum Action {
		case dismissButtonDidTap
	}
	
	enum Mutation {
		
	}
	
	struct State {
		
	}
	
		// MARK: Properties
	
	let initialState: State
	let provider: ServiceProviderType
	
		// MARK: Initializers
	
	init(provider: ServiceProviderType) {
		initialState = State()
		self.provider = provider
	}
}
