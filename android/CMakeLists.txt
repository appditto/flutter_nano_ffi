cmake_minimum_required(VERSION 3.6 FATAL_ERROR)
project(ed25519_blake2b VERSION 1.0.0 LANGUAGES C)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

add_library(ed25519_blake2b SHARED ../ios/Classes/ed25519_blake2b/ed25519_blake2b.c)

file(GLOB Ed25519_SOURCES ../ios/Classes/ed25519_blake2b/ed25519-donna/*.c)
file(GLOB Ed25519_HEADER ../ios/Classes/ed25519_blake2b/ed25519-donna/*.h) 
add_library(ed25519-donna ${Ed25519_SOURCES} ${Ed25519_HEADER})

target_link_libraries(ed25519_blake2b ed25519-donna)

set_target_properties(ed25519_blake2b PROPERTIES
    PUBLIC_HEADER ../ios/Classes/ed25519_blake2b/ed25519_blake2b.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "ed25519_blake2b"
)