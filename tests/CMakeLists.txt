# Enable testing
enable_testing()

# Define test executable
add_executable(unit_tests
    test_streambuf.cpp
)

# Link libraries
target_link_libraries(unit_tests
    GTest::gtest_main
    Boost::boost
)

# Register tests
add_test(NAME streambuf_test COMMAND unit_tests)
