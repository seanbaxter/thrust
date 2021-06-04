# The cmake tests currently only check the default system configuration of
# host=CPP and device=CUDA. If either of these systems are not used by the
# current build, skip cmake testing.
thrust_update_system_found_flags()
if (NOT THRUST_CPP_FOUND OR NOT THRUST_CUDA_FOUND)
  return()
endif()

# Setup a new CMake project with the same settings as the current build:
set(test_cmake_configure_flags
  --log-level=VERBOSE
  -G "${CMAKE_GENERATOR}"
  -D "ORIG_THRUST_SOURCE_DIR=${Thrust_SOURCE_DIR}"
  -D "ORIG_THRUST_BINARY_DIR=${Thrust_BINARY_DIR}"
  -D "CMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  -D "CMAKE_CUDA_COMPILER=${CMAKE_CUDA_COMPILER}"
  -D "CMAKE_CUDA_HOST_COMPILER=${CMAKE_CUDA_HOST_COMPILER}"
  -D "CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
)
if (CMAKE_CUDA_COMPILER_ID STREQUAL "NVCXX")
  list(APPEND test_cmake_configure_flags
    -D "CMAKE_CUDA_COMPILER_ID=${CMAKE_CUDA_COMPILER_ID}"
    -D "CMAKE_CUDA_COMPILER_FORCED=${CMAKE_CUDA_COMPILER_FORCED}"
  )
endif()

# Include testing stubs:
include(test_install.cmake)
include(test_shared_linking.cmake)
