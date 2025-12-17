//
//  ManualTypeEraserUnlockExistential.swift
//  Programming
//
//  Created by ke Liu on 12/13/25.
//

struct AnyRestorable2<State: Codable> {
    private var _value: any Restorable
    init<R: Restorable>(_ value: R) where R.State == State {
        self._value = value
    }
}

private extension Restorable {
    // Forward to the requirement in an existential-accessible way.
    func _getStateThunk<_State>() -> _State {
        assert(_State.self == State.self)
        return unsafeBitCast(state, to: _State.self)
    }
    mutating func _setStateThunk<_State>(newValue: _State) {
        assert(_State.self == State.self)
        state = unsafeBitCast(newValue, to: State.self)
    }
}

extension AnyRestorable2: Restorable {
    var state: State {
        get { _value._getStateThunk() }
        set { _value._setStateThunk(newValue: newValue) }
    }
}
