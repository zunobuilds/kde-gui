fn main() {
    #[cfg(feature = "qt")]
    {
        use cxx_qt_build::{CxxQtBuilder, QmlModule};

        CxxQtBuilder::new_qml_module(
            QmlModule::new("org.zunobuilds.kdegui").qml_file("qml/CounterView.qml"),
        )
        .file("src/qt.rs")
        .qt_module("QuickControls2")
        .build();
    }
}
