cmake_minimum_required(VERSION 2.6)
PROJECT(thelib)

#make the list with all the source files
FILE(GLOB_RECURSE SOURCES "${CMAKE_SOURCE_DIR}/thelib/src/*.cpp" )

#prepare the include directories
INCLUDE_DIRECTORIES(
	${OPENSSL_INCLUDE_DIRS}
	${LUA_INCLUDE_DIRS}
	${CMAKE_SOURCE_DIR}/common/include
	${CMAKE_SOURCE_DIR}/thelib/include
	)

#create the library
ADD_LIBRARY(${PROJECT_NAME} ${LIB_TYPE} ${SOURCES})
IF(${LIB_TYPE} MATCHES "SHARED")
	TARGET_LINK_LIBRARIES(${PROJECT_NAME} 
		common 
		${DL_LIBRARY_PATH} 
		${OPENSSL_LIBRARIES}
		#/opt/local/lib/libiconv.dylib
		#/Users/shiretu/work/ffmpeg_bin/lib/libavcodec.dylib
		#/Users/shiretu/work/ffmpeg_bin/lib/libavformat.dylib
		#/Users/shiretu/work/ffmpeg_bin/lib/libavutil.dylib
		)	
	INSTALL(TARGETS ${PROJECT_NAME} LIBRARY DESTINATION ${CRTMPSERVER_ROOT})
ENDIF(${LIB_TYPE} MATCHES "SHARED")

INSTALL(DIRECTORY ${CMAKE_SOURCE_DIR}/${PROJECT_NAME}/include/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/include/crtmpserver/${PROJECT_NAME}
	FILES_MATCHING PATTERN "*.h")
