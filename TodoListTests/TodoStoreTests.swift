import Testing
import Foundation
@testable import TodoList

struct TodoStoreTests {
    private func makeStore() -> TodoStore {
        let suiteName = "test-\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        return TodoStore(defaults: defaults)
    }

    @Test func addingTrimsWhitespaceAndInsertsAtTop() {
        let store = makeStore()
        store.add(title: "  Buy milk  ")
        store.add(title: "Walk dog")

        #expect(store.items.count == 2)
        #expect(store.items.first?.title == "Walk dog")
        #expect(store.items.last?.title == "Buy milk")
    }

    @Test func addingBlankTitleIsIgnored() {
        let store = makeStore()
        store.add(title: "   ")
        #expect(store.items.isEmpty)
    }

    @Test func togglingFlipsIsDone() {
        let store = makeStore()
        store.add(title: "Buy milk")
        let item = store.items[0]

        store.toggle(item)
        #expect(store.items[0].isDone == true)

        store.toggle(item)
        #expect(store.items[0].isDone == false)
    }

    @Test func deletingRemovesItem() {
        let store = makeStore()
        store.add(title: "Buy milk")
        store.add(title: "Walk dog")

        store.delete(at: IndexSet(integer: 0))
        #expect(store.items.count == 1)
        #expect(store.items.first?.title == "Buy milk")
    }
}
