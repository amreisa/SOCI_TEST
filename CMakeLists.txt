cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(soci-download LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)

find_package( Boost COMPONENTS system filesystem program_options thread date_time REQUIRED )
    include_directories( ${Boost_INCLUDE_DIR} )
    link_directories( ${Boost_LIBRARY_DIRS} )
    set( Boost_USE_STATIC_LIBS        TRUE  )
    set( Boost_USE_MULTITHREADED      TRUE  )
    set( Boost_USE_STATIC_RUNTIME     TRUE )
    set( BOOST_ALL_DYN_LINK           FALSE )

    if ( APPLE OR WIN32 )
        set( Boost_USE_STATIC_LIBS TRUE )
    endif()

    include_directories( SYSTEM ${Boost_INCLUDE_DIRS} )

FetchContent_Declare(
  soci-git
  GIT_REPOSITORY https://github.com/SOCI/soci.git
  GIT_TAG        master
)

add_compile_definitions( SOCI_HAVE_CXX11 )

set(SOCI_SHARED OFF CACHE BOOL "")
#set(SOCI_CXX11 ON CACHE BOOL "")

FetchContent_MakeAvailable(soci-git)


add_executable(socidl main.cpp)
target_include_directories( socidl PRIVATE . )
target_link_libraries( socidl PRIVATE soci_core soci_sqlite3 Boost::system
        Boost::filesystem
        Boost::thread
        Boost::program_options sqlite3 dl
        )
