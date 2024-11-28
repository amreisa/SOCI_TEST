cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(soci-download LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# genrate compile db for clang completion
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package( Boost COMPONENTS date_time REQUIRED )
find_package( unofficial-sqlite3 CONFIG REQUIRED )
find_package( SOCI CONFIG REQUIRED )

add_executable(socidl main.cpp)
target_include_directories( socidl PRIVATE . )

target_link_libraries(socidl PRIVATE
    unofficial::sqlite3::sqlite3
    $<IF:$<TARGET_EXISTS:SOCI::soci_sqlite3>,SOCI::soci_sqlite3,SOCI::soci_sqlite3_static>
    $<IF:$<TARGET_EXISTS:SOCI::soci_core>,SOCI::soci_core,SOCI::soci_core_static>
)

#set( SOCI_STATIC ON CACHE BOOL "" )