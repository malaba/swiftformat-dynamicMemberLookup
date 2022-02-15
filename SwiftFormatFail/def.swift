protocol SomeCommonProtocol {
    var id: String { get }
    var title: String { get }
    var description: String { get }
}

struct CurrentThing: SomeCommonProtocol {
    let id: String
    let title: String
    let description: String

    let otherStuff: String
    let aThing: Int
}

struct NextThing: SomeCommonProtocol {
    let id: String
    let title: String
    let description: String

    let fallback: Int
    let order: Int
}

@dynamicMemberLookup
enum SomeType {
    case current(CurrentThing)
    case next(NextThing)
}

extension SomeType {
    subscript<T>(dynamicMember keyPath: KeyPath<SomeCommonProtocol, T>) -> T {
        switch self {
        case let .current(current):
            return current[keyPath: keyPath]
        case let .next(next):
            return next[keyPath: keyPath]
        }
    }
}

private extension SomeType {
    var analyticsId: String {
        self.id
    }
}

// Usage example:
func dummy() {
    let c = CurrentThing(id: "first", title: "aTitle", description: "blahblah", otherStuff: "oo", aThing: 6)
    let s: SomeType = .current(c)

    print("\(s.id), \(s.title), \(s.description), \(s.analyticsId)")
}
