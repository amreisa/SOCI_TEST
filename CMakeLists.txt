cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(soci-download LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# genrate compile db for clang completion
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (APPLE OR WIN32)
    set(Boost_USE_STATIC_LIBS TRUE)
endif()

### get boost ###
# does not work on my linux
#set( Boost_USE_STATIC_LIBS        TRUE  )
#set( Boost_USE_MULTITHREADED      TRUE  )
#set( Boost_USE_STATIC_RUNTIME     TRUE )
#set( BOOST_ALL_DYN_LINK           FALSE )
find_package( Boost COMPONENTS date_time REQUIRED )

#bad style - use targets instead
#include_directories( ${Boost_INCLUDE_DIR} )
#include_directories( SYSTEM ${Boost_INCLUDE_DIRS} )
#link_directories( ${Boost_LIBRARY_DIRS} )


### get soci ###
include(FetchContent)
FetchContent_Declare(
    soci-git
    GIT_REPOSITORY https://github.com/SOCI/soci.git
    GIT_TAG        master
    )

# bullshit - work with targets && do not add defines when the poject offers camek options
#add_compile_definitions( SOCI_HAVE_CXX11 )

set( SOCI_CXX11 ON CACHE BOOL "" )
set( WITH_BOOST ON CACHE BOOL "" )
set( SOCI_TESTS OFF CACHE BOOL "" )
set( SOCI_SHARED OFF CACHE BOOL "" )
set( SOCI_STATIC ON CACHE BOOL "" )

set( SOCI_EMPTY OFF CACHE BOOL "" )
set( SOCI_ORACLE OFF CACHE BOOL "" )
set( SOCI_ODBC OFF CACHE BOOL "" )
set( SOCI_SQLITE3 ON CACHE BOOL "" )
set( SOCI_MYSQL OFF CACHE BOOL "" )
set( SOCI_POSTGRESQL OFF CACHE BOOL "" )
set( SOCI_FIREBIRD OFF CACHE BOOL "" )
set( SOCI_DB2 OFF CACHE BOOL "" )
FetchContent_MakeAvailable(soci-git)

add_executable(socidl main.cpp)
target_include_directories( socidl PRIVATE . )

if(NOT TARGET soci_core_static)
    message(FATAL_ERROR "soci core is not available")
endif()
if(NOT TARGET soci_sqlite3_static)
    message(FATAL_ERROR "soci sqlite3 is not available")
endif()

target_link_libraries(socidl PRIVATE
    soci_sqlite3_static #<<- this needs symbols from core, therefor you need to put it first (try to toggle! and see what happens)
    soci_core_static
)

#if the cmmake was done correctly in soci this would not be needed:
#set(CMAKE_INCLUDE_CURRENT_DIR ON) <<- they should add this in their code
target_include_directories( socidl PRIVATE ${soci-git_BINARY_DIR}/include )
