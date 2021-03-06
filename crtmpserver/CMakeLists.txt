cmake_minimum_required(VERSION 2.6)
PROJECT(crtmpserver)

#prepare the include directories
INCLUDE_DIRECTORIES(
	${LUA_INCLUDE_DIRS}
	${CMAKE_SOURCE_DIR}/common/include
	${CMAKE_SOURCE_DIR}/thelib/include
)

IF(${LIB_TYPE} MATCHES "STATIC")
	GET_PROPERTY(APPS_DEFINES GLOBAL PROPERTY ACTIVE_APPS)
	GET_PROPERTY(APPS_LIBS GLOBAL PROPERTY ACTIVE_APPS_LIBS)
	ADD_DEFINITIONS(${APPS_DEFINES})
ELSE(${LIB_TYPE} MATCHES "STATIC")
	SET(APPS_LIBS "")
ENDIF(${LIB_TYPE} MATCHES "STATIC")

IF(NOT DEFINED TEMP_FRAMEWORK_VER)
	EXECUTE_PROCESS(COMMAND svnversion -n ${CMAKE_SOURCE_DIR} OUTPUT_VARIABLE TEMP_FRAMEWORK_VER)
	SET(TEMP_FRAMEWORK_VER "0.${TEMP_FRAMEWORK_VER}")
ENDIF(NOT DEFINED TEMP_FRAMEWORK_VER)
ADD_DEFINITIONS(-DRTMPSERVER_VERSION="${TEMP_FRAMEWORK_VER}")

ADD_EXECUTABLE(${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/crtmpserver/src/crtmpserver.cpp)

TARGET_LINK_LIBRARIES(${PROJECT_NAME}
	${APPS_LIBS}
	thelib
	common
	${TINYXML_LIBRARIES}
	${LUA_LIBRARIES}
	${OPENSSL_LIBRARIES}
	${DL_LIBRARY_PATH}
)

INSTALL(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION sbin)
#INSTALL(FILES crtmpserver.lua DESTINATION etc RENAME crtmpserver.lua.sample)
#INSTALL(FILES ../../../man/crtmpserver.1 DESTINATION man/man1)

