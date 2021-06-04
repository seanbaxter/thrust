# Test that we can link two shared libraries that consumer Thrust, so long as
# their namespaces are configured properly:

# Wrapped in a function to limit variable scope:
function(setup_test_shared_linking)
  set(test_prefix thrust.test.cmake.test_shared_linking)
  set(src_dir "${CMAKE_CURRENT_SOURCE_DIR}/test_shared_linking")
  set(build_dir "${CMAKE_CURRENT_BINARY_DIR}/test_shared_linking")

  add_test(
    NAME ${test_prefix}_configure
    COMMAND "${CMAKE_COMMAND}"
      -S "${src_dir}"
      -B "${build_dir}"
      ${test_cmake_configure_flags}
  )

  add_test(
    NAME ${test_prefix}_build
    COMMAND "${CMAKE_COMMAND}"
      --build ${build_dir}
      -j3
  )

  add_test(
    NAME ${test_prefix}
    COMMAND "${CMAKE_CTEST_COMMAND}" --extra-verbose
    WORKING_DIRECTORY "${build_dir}"
  )

  # Configure dependencies as fixtures:
  set_tests_properties(${test_prefix}_configure PROPERTIES
    FIXTURES_SETUP ${test_prefix}_configure_fixture
  )
  set_tests_properties(${test_prefix}_build PROPERTIES
    FIXTURES_REQUIRED ${test_prefix}_configure_fixture
    FIXTURES_SETUP ${test_prefix}_build_fixture
  )
  set_tests_properties(${test_prefix} PROPERTIES
    FIXTURES_REQUIRED ${test_prefix}_build_fixture
  )
endfunction()
setup_test_shared_linking()
