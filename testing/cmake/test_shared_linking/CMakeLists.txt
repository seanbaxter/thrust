# Regression test for NVIDIA/thrust#1401.
#
# Creates two shared libraries that use thrust internally (from unique
# namespaces), and links them both to a single executable that invokes Thrust
# indirectly from each shared lib.
cmake_minimum_required(VERSION 3.15)

# Our build harness doesn't use CUDA_ARCHITECTURES yet. We can remove this
# and pass those in once we do.
if (CMAKE_VERSION VERSION_GREATER_EQUAL 3.18)
  cmake_policy(SET CMP0104 OLD)
endif()

project(ThrustTestSharedLinking CXX CUDA)

set(Thrust_DIR "${ORIG_THRUST_SOURCE_DIR}/thrust/cmake")
message("Looking for Thrust in ${Thrust_DIR}")
find_package(Thrust CONFIG COMPONENTS CPP CUDA)
thrust_create_target(Thrust)

add_library(foo SHARED foo_lib.cu)
target_compile_definitions(foo PRIVATE "BUILDING_DLL")
target_link_libraries(foo PRIVATE Thrust)

add_library(bar SHARED bar_lib.cu)
target_compile_definitions(bar PRIVATE "BUILDING_DLL")
target_link_libraries(bar PRIVATE Thrust)

enable_testing()

add_executable(run_test run_test.cu)
target_link_libraries(run_test PRIVATE foo bar)
add_test(NAME run_test COMMAND run_test)
