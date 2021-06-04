# Test that we can use `find_package` on an installed Thrust:
add_test(
  NAME thrust.test.cmake.test_install
  COMMAND "${CMAKE_COMMAND}"
    -S "${CMAKE_CURRENT_SOURCE_DIR}/test_install"
    -B "${CMAKE_CURRENT_BINARY_DIR}/test_install"
    ${test_cmake_configure_flags}
)
