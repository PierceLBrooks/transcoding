cmake_minimum_required(VERSION 3.15.0)

project(TranscodingDemo)

include(FindPkgConfig)

if (NOT "$ENV{FFMPEG_INCLUDE_DIRS}" STREQUAL "" AND NOT "$ENV{FFMPEG_LIBRARIES}" STREQUAL "")
    set(FFMPEG_INCLUDE_DIRS $ENV{FFMPEG_INCLUDE_DIRS})
    set(FFMPEG_LIBRARIES $ENV{FFMPEG_LIBRARIES})
elseif(PKG_CONFIG_FOUND)
    pkg_check_modules(FFMPEG REQUIRED libavcodec libavfilter libavformat libavutil libswresample libswscale)
else()
    message(FATAL_ERROR "ffmpeg could not be found")
endif()

set(SRC )
list(APPEND SRC ${CMAKE_CURRENT_LIST_DIR}/src/demo.c)
list(APPEND SRC ${CMAKE_CURRENT_LIST_DIR}/src/io_in_memory.c)
list(APPEND SRC ${CMAKE_CURRENT_LIST_DIR}/src/transcoding.c)

include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
include_directories(${FFMPEG_INCLUDE_DIRS})
link_directories(${FFMPEG_INCLUDE_DIRS}/../lib)
link_libraries(${FFMPEG_LIBRARIES})

add_executable(transcoding_demo ${SRC})
install(TARGETS transcoding_demo)

