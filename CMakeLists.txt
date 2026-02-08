cmake_minimum_required(VERSION 3.10)
project(StaticFileServerShadowing VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find dependencies
find_package(Boost REQUIRED)
find_package(GTest REQUIRED)

# Include directories
include_directories(include)

# Enable testing
enable_testing()

# Add subdirectories
# add_subdirectory(src) # Uncomment when src/CMakeLists.txt is ready
add_subdirectory(tests)
