import QtQuick
import QtTest
import org.zunobuilds.kdegui

Item {
    id: root
    width: 200
    height: 100

    Component {
        id: stateComponent
        CounterState { }
    }

    SignalSpy {
        id: valueSpy
        signalName: "valueChanged"
    }

    TestCase {
        name: "CounterState"
        when: windowShown

        function test_incrementNotifiesOnce() {
            let state = createTemporaryObject(stateComponent, root)
            verify(!!state, "Component exists")
            compare(state.value, 0)
            valueSpy.target = state
            valueSpy.clear()
            state.increment()
            compare(state.value, 1)
            compare(valueSpy.count, 1)
        }

        function test_valueIsReadOnly() {
            let state = createTemporaryObject(stateComponent, root)
            verify(!!state, "Component exists")
            let rejected = false
            try {
                state.value = 42
            } catch (error) {
                rejected = true
            }
            verify(rejected)
            compare(state.value, 0)
        }
    }
}
