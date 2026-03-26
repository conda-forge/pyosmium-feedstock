#!/bin/bash
set -ex

# Remove contrib folder as it contains libosmium and protozero
# which will be provided as conda dependencies
rm -rf contrib

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then

    # Target an Apple Silicon build from an Intel macOS builder.
    export ARCHFLAGS="-arch arm64"

    # conda-build sets these; pass the sysroot through to CMake explicitly.
    export CMAKE_ARGS="${CMAKE_ARGS:-} \
      -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} \
      -DCMAKE_OSX_ARCHITECTURES=arm64"
fi

# Build and install the package
${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
