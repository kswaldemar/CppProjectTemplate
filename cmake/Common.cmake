# Function to link between sub-projects
function(add_dependent_subproject subproject_name)
    #if (NOT TARGET ${subproject_name}) # target unknown
    if(NOT PROJECT_${subproject_name}) # var unknown because we build only this subproject, ProjA must have been built AND installed
        find_package(${subproject_name} CONFIG REQUIRED)
    else () # we know the target thus we are doing a build from the top directory
        include_directories(../${subproject_name}/include)
    endif ()
endfunction(add_dependent_subproject)

# Make sure we tell the topdir CMakeLists that we exist (if build from topdir)
get_directory_property(hasParent PARENT_DIRECTORY)
if(hasParent)
    set(PROJECT_${PROJECT_NAME} true PARENT_SCOPE)
endif()

macro(add_cpack_target)
    ADD_CUSTOM_TARGET(package${PROJECT_NAME}
        COMMAND cpack --config ${CPACK_OUTPUT_CONFIG_FILE} # Generate package files with accordance to subproject config
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    )
endmacro(add_cpack_target)