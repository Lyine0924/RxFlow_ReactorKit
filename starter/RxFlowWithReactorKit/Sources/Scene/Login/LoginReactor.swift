//
//  LoginReactor.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import Foundation

import RxSwift
import RxCocoa
import RxFlow
import ReactorKit

final class LoginReactor: Reactor, Stepper {
	
	struct Dependency {
		let provider: ServiceProviderType
	}

	enum Action {
		case loginButtonDidTap
	}
	
	enum Mutation {
	}
	
	struct State {
	}
	
	// MARK: Properties
	
	var steps: PublishRelay<Step> = .init()
	
	var dependency: Dependency
	
	let initialState: State
	
	init(dependency: Dependency) {
		self.initialState = State()
		self.dependency = dependency
	}
}

// MARK: Mutation

extension LoginReactor {
	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
			case .loginButtonDidTap:
				self.dependency.provider.loginService.setUserLogin()
				
				steps.accept(SampleStep.loginIsCompleted)
				
				return .empty()
		}
	}
}

// MARK: Reduce

extension LoginReactor {
	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state
		return newState
	}
}
