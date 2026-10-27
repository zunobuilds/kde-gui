use std::pin::Pin;

use cxx_qt::CxxQtType;

use crate::Counter;

#[cxx_qt::bridge(namespace = "kde_gui")]
mod ffi {
    extern "RustQt" {
        #[qobject]
        #[qml_element]
        #[qproperty(i32, value, READ = value, NOTIFY)]
        type CounterState = super::CounterStateRust;

        fn value(self: &CounterState) -> i32;

        #[qinvokable]
        fn increment(self: Pin<&mut CounterState>);
    }
}

#[derive(Default)]
pub struct CounterStateRust {
    counter: Counter,
}

impl ffi::CounterState {
    pub fn value(&self) -> i32 {
        self.rust().counter.value()
    }

    pub fn increment(mut self: Pin<&mut Self>) {
        if self.as_mut().rust_mut().counter.increment() {
            self.as_mut().value_changed();
        }
    }
}
