//
//  HomeReactor.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import Foundation

import RxFlow
import RxCocoa
import ReactorKit

final class HomeReactor: Reactor, Stepper {
	
	// MARK: Stepper
	
	var steps: PublishRelay<Step> = .init()
	
	// MARK: Events
	
	enum Action {

	}
	
	enum Mutation {

	}
	
	struct State {

	}
	
	// MARK: Properties
	
	let initialState: State
	private let provider: ServiceProviderType
	
	let errorSubject: PublishSubject<Error> = .init()
	
	init(provider: ServiceProviderType) {
		initialState = State()
		self.provider = provider
	}
}

// MARK: Mutation

extension HomeReactor {
	func mutate(action: Action) -> Observable<Mutation> {
		return .empty()
	}
}

// MARK: Reduce

extension HomeReactor {
	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state
		return newState
	}
}

