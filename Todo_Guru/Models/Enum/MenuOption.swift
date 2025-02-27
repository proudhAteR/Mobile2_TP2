import Foundation
import SwiftUICore

enum MenuOption: String, Identifiable, CaseIterable {
	var id: Self { self }

	case tasks
	case group

	var img: Image {
		switch self {
		case .tasks:
			return Image(systemName: "list.bullet.clipboard.fill")
		case .group:
			return Image(systemName: "person.3.fill")
		}
	}

	var view: AnyView {
		switch self {
		case .tasks:
			return AnyView(TaskListView())
		case .group:
			return AnyView(EmptyView())
		}
	}
}
