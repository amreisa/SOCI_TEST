cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(soci-download NONE)

include(ExternalProject)

ExternalProject_Add(
	soci
	SOURCE_DIR "@SOCI_DOWNLOAD_ROOT@/soci-src"
	BINARY_DIR "@SOCI_DOWNLOAD_ROOT@/src-build"
	GIT_REPOSITORY file://${PROJECT_SOURCE_DIR}/soci #https://github.com/SOCI/soci.git
        CMAKE_ARGS -DSOCI_CXX11=ON -DSOCI_TESTS=OFF -DSOCI_SHARED=OFF
#	CONFIGURE_COMMAND ""
#	BUILD_COMMAND ""
#	INSTALL_COMMAND ""
#	TEST_COMMAND ""
)
