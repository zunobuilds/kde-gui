cmake_minimum_required(VERSION 3.24)
project(kde_gui_qml_consumer LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Gui Qml)
add_executable(kde_gui_qml_consumer main.cpp)
target_compile_features(kde_gui_qml_consumer PRIVATE cxx_std_17)
target_link_libraries(kde_gui_qml_consumer PRIVATE Qt6::Gui Qt6::Qml)
