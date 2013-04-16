find_package(PkgConfig)
pkg_check_modules(OYRANOS oyranos)


if(OYRANOS_CFLAGS AND OYRANOS_LIBRARY_DIRS)

  # query pkg-config asking for Oyranos >= 0.4.0
  EXEC_PROGRAM(${PKGCONFIG_EXECUTABLE} ARGS --atleast-version=0.9.0 oyranos RETURN_VALUE _return_VALUE OUTPUT_VARIABLE _pkgconfigDevNull )

  if(_return_VALUE STREQUAL "0")
    set(OYRANOS_FOUND TRUE)
    set(HAVE_OYRANOS TRUE)
  else(_return_VALUE STREQUAL "0")
    message(STATUS "Oyranos >= 0.9.0 was found")
  endif(_return_VALUE STREQUAL "0")
endif(OYRANOS_CFLAGS AND OYRANOS_LIBRARY_DIRS)

if (OYRANOS_FOUND)
    if (NOT Oyranos_FIND_QUIETLY)
        message(STATUS "Found OYRANOS: ${OYRANOS_LIBRARY_DIRS} ${OYRANOS_INCLUDE_DIRS}")
    endif (NOT Oyranos_FIND_QUIETLY)
else (OYRANOS_FOUND)
    if (NOT Oyranos_FIND_QUIETLY)
        message(STATUS "Oyranos was NOT found.")
    endif (NOT Oyranos_FIND_QUIETLY)
    if (Oyranos_FIND_REQUIRED)
        message(FATAL_ERROR "Could NOT find Oyranos")
    endif (Oyranos_FIND_REQUIRED)
endif (OYRANOS_FOUND)

