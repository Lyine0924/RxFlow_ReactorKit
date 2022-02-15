//
//  HomeCell.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/15.
//

import UIKit
import RxCocoa
import ReactorKit

final class HomeCell: UITableViewCell {
	
	// MARK: Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		
	}
}
