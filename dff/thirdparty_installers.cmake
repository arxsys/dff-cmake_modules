FILE(GLOB dependencies "${WINALL}/*")

LIST(APPEND THIRDPARTY_INSTALLERS "")

foreach(file ${dependencies})
  IF (NOT IS_DIRECTORY(${file}))
    split_path_file_extension(${file})
    string(TOLOWER ${__FILE__} file_lower)
    IF (NOT PYTHON_INSTALLER)
      STRING(REGEX MATCH "^python.*" PYTHON_INSTALLER "${file_lower}")
      if (NOT PYTHON_INSTALLER STREQUAL "")
	set (PYTHON_INSTALLER ${__FILE__})
	LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
      endif ()
    ENDIF (NOT PYTHON_INSTALLER)
    IF (NOT PYQT_INSTALLER)
      STRING(REGEX MATCH "^pyqt.*" PYQT_INSTALLER "${file_lower}")
      if (NOT PYQT_INSTALLER STREQUAL "")
	set (PYQT_INSTALLER ${__FILE__})
		LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
      endif ()
    ENDIF (NOT PYQT_INSTALLER)
    IF (NOT VCREDIST10_INSTALLER)
      STRING(REGEX MATCH "^vcredist2010.*" VCREDIST10_INSTALLER "${file_lower}")
      if (NOT VCREDIST10_INSTALLER STREQUAL "")
	set (VCREDIST10_INSTALLER ${__FILE__})
	LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
      endif ()
    ENDIF (NOT VCREDIST10_INSTALLER)
    IF (NOT VCREDIST13_INSTALLER)
      STRING(REGEX MATCH "^vcredist2013.*" VCREDIST13_INSTALLER "${file_lower}")
      if (NOT VCREDIST13_INSTALLER STREQUAL "")
	set (VCREDIST13_INSTALLER ${__FILE__})
	LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
      endif ()
    ENDIF (NOT VCREDIST13_INSTALLER)
    IF (NOT APSW_INSTALLER)
      STRING(REGEX MATCH "^apsw.*" APSW_INSTALLER "${file_lower}")
      if (NOT APSW_INSTALLER STREQUAL "")
	set (APSW_INSTALLER ${__FILE__})
		LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
      endif ()
    ENDIF (NOT APSW_INSTALLER)
    IF (NOT PIL_INSTALLER)
      STRING(REGEX MATCH "^pil.*" PIL_INSTALLER "${file_lower}")
      if (NOT PIL_INSTALLER STREQUAL "")
	set (PIL_INSTALLER ${__FILE__})
		LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
      endif ()
    ENDIF ()
    IF (NOT VOLATILITY_INSTALLER)
      STRING(REGEX MATCH "^volatility.*" VOLATILITY_INSTALLER "${file_lower}")
      if (NOT VOLATILITY_INSTALLER STREQUAL "")
	set (VOLATILITY_INSTALLER ${__FILE__})
		LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
      endif ()
    ENDIF ()
    if (BUILD_UNSUPPORTED)
      if (NOT MATPLOTLIB_INSTALLER)
	STRING(REGEX MATCH "^matplotlib.*" MATPLOTLIB_INSTALLER "${file_lower}")
	if (NOT MATPLOTLIB_INSTALLER STREQUAL "")
	  set (MATPLOTLIB_INSTALLER ${__FILE__})
	  	LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
	endif ()
      endif ()
      if (NOT NUMPY_INSTALLER)
	STRING(REGEX MATCH "^numpy.*" NUMPY_INSTALLER "${file_lower}")
	if (NOT NUMPY_INSTALLER STREQUAL "")
	  set (NUMPY_INSTALLER ${__FILE__})
	  	LIST(APPEND THIRDPARTY_INSTALLERS ${__FILE__})
	endif ()
      endif ()
    endif()
  ENDIF (NOT IS_DIRECTORY(${file}))
endforeach()

set(cmds "")
foreach(file ${THIRDPARTY_INSTALLERS})
	 if (cmds)
	    set(cmds ${cmds} &&)
	 endif (cmds)
	 set(cmds ${cmds} ${CMAKE_COMMAND} -E copy_if_different ${WINALL}/${file} ${CMAKE_BINARY_DIR}/prerequisites/${file})
	 install(FILES ${CMAKE_BINARY_DIR}/prerequisites/${file} DESTINATION ${INSTALL_FILE_DESTINATION}/prerequisites)
endforeach(file ${THIRDPARTY_INSTALLERS})


add_custom_target("dff.thirdparty_installers" ALL ${cmds})