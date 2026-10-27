cmake_minimum_required(VERSION 3.24)
project(kde_gui LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Qml QuickControls2)
find_program(CARGO_EXECUTABLE cargo REQUIRED)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(FATAL_ERROR "QML plugin packaging is currently supported only on Linux.")
endif()

set(cargo_target "${CMAKE_CURRENT_BINARY_DIR}/cargo-target")
set(cxxqt_export "${CMAKE_CURRENT_BINARY_DIR}/cxxqt")
set(module_path "org/zunobuilds/kdegui")
set(module_export "${cxxqt_export}/qml_modules/${module_path}")
set(module_output "${CMAKE_CURRENT_BINARY_DIR}/qml/${module_path}")
set(rust_archive "${cargo_target}/release/libkde_gui.a")

add_custom_command(
    OUTPUT "${rust_archive}"
    BYPRODUCTS "${module_export}/qmldir" "${module_export}/plugin.qmltypes"
               "${module_export}/qml/CounterView.qml"
    COMMAND "${CMAKE_COMMAND}" -E env
        "CARGO_TARGET_DIR=${cargo_target}"
        "CXX_QT_EXPORT_DIR=${cxxqt_export}"
        "QMAKE=$<TARGET_FILE:Qt6::qmake>"
        "${CARGO_EXECUTABLE}" build --manifest-path "${CMAKE_CURRENT_SOURCE_DIR}/Cargo.toml"
        --release --features qt --locked
    DEPENDS Cargo.toml Cargo.lock build.rs src/lib.rs src/qt.rs qml/CounterView.qml
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    VERBATIM
)
add_custom_target(kde_gui_rust DEPENDS "${rust_archive}")

add_library(kde_gui_plugin MODULE native/plugin.cpp)
add_dependencies(kde_gui_plugin kde_gui_rust)
target_link_libraries(kde_gui_plugin PRIVATE "${rust_archive}"
    Qt6::Core Qt6::Qml Qt6::QuickControls2 ${CMAKE_DL_LIBS} pthread m)
set_target_properties(kde_gui_plugin PROPERTIES
    OUTPUT_NAME org_zunobuilds_kdegui
    LIBRARY_OUTPUT_DIRECTORY "${module_output}"
)
add_custom_command(TARGET kde_gui_plugin POST_BUILD
    COMMAND "${CMAKE_COMMAND}" -E copy_if_different
        "${module_export}/qmldir" "${module_export}/plugin.qmltypes" "${module_output}"
    COMMAND "${CMAKE_COMMAND}" -E copy_directory
        "${module_export}/qml" "${module_output}/qml"
    VERBATIM
)

include(GNUInstallDirs)
set(KDE_GUI_QML_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/qt6/qml" CACHE STRING
    "QML import directory relative to the installation prefix")
install(TARGETS kde_gui_plugin LIBRARY DESTINATION "${KDE_GUI_QML_INSTALL_DIR}/${module_path}")
install(FILES "${module_export}/qmldir" "${module_export}/plugin.qmltypes"
    DESTINATION "${KDE_GUI_QML_INSTALL_DIR}/${module_path}")
install(FILES "${module_export}/qml/CounterView.qml"
    DESTINATION "${KDE_GUI_QML_INSTALL_DIR}/${module_path}/qml")
install(FILES LICENSE-MIT LICENSE-APACHE
    DESTINATION "${CMAKE_INSTALL_DATADIR}/licenses/kde-gui")

include(CTest)
if(BUILD_TESTING)
    find_program(QMLTESTRUNNER_EXECUTABLE NAMES qmltestrunner-qt6 qmltestrunner REQUIRED)
    add_test(NAME qml-counter COMMAND "${QMLTESTRUNNER_EXECUTABLE}"
        -input "${CMAKE_CURRENT_SOURCE_DIR}/tests")
    set_tests_properties(qml-counter PROPERTIES TIMEOUT 30
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen;QSG_RHI_BACKEND=software;QT_FORCE_STDERR_LOGGING=1;QML_IMPORT_PATH=${CMAKE_CURRENT_BINARY_DIR}/qml")
endif()
