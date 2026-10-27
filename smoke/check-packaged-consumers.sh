#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
if [[ $# != 1 ]]; then
    echo "Usage: bash smoke/check-packaged-consumers.sh <installed-qml-import-root>" >&2
    exit 2
fi
import_root=$(realpath -- "$1")
module_path=org/zunobuilds/kdegui
if [[ ! -f "$import_root/$module_path/qmldir" ]]; then
    echo "Installed counter module not found in the supplied import root." >&2
    exit 1
fi

cd -- "$repo_dir"
cargo package --allow-dirty --locked --offline --target-dir "$repo_dir/target"
proof_dir=$(mktemp -d "$repo_dir/target/consumer-proof.XXXXXX")
tar -xzf target/package/kde-gui-0.1.0.crate -C "$proof_dir"
mkdir -p "$proof_dir/rust-consumer" "$proof_dir/qml-consumer" "$proof_dir/tests" \
    "$proof_dir/imports/org/zunobuilds"
cp smoke/rust-consumer/Cargo.toml smoke/rust-consumer/Cargo.lock "$proof_dir/rust-consumer/"
cp -R smoke/rust-consumer/src "$proof_dir/rust-consumer/"
cp smoke/qml-consumer/CMakeLists.txt smoke/qml-consumer/main.cpp \
    smoke/qml-consumer/Main.qml "$proof_dir/qml-consumer/"
cp tests/tst_*.qml "$proof_dir/tests/"
cp -R "$import_root/$module_path" "$proof_dir/imports/org/zunobuilds/"
sed -i 's|path = "../.."|path = "../kde-gui-0.1.0"|' "$proof_dir/rust-consumer/Cargo.toml"

cd -- "$proof_dir"
CARGO_TARGET_DIR="$proof_dir/rust-target" cargo run \
    --manifest-path rust-consumer/Cargo.toml --locked --offline
cmake -S qml-consumer -B qml-build -G Ninja
cmake --build qml-build

unset QML2_IMPORT_PATH
export QML_IMPORT_PATH="$proof_dir/imports"
export QT_QPA_PLATFORM=offscreen
export QSG_RHI_BACKEND=software
export QT_FORCE_STDERR_LOGGING=1
qml-build/kde_gui_qml_consumer "$proof_dir/qml-consumer/Main.qml" --check
qmltestrunner=$(command -v qmltestrunner-qt6 || command -v qmltestrunner)
"$qmltestrunner" -input tests
echo "Independent consumer checks passed. Artifacts: $proof_dir"
