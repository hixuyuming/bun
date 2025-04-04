find_command(
  VARIABLE
    GIT_PROGRAM
  COMMAND
    git
  REQUIRED
    OFF
)

if(NOT GIT_PROGRAM)
  return()
endif()

set(GIT_DIFF_COMMAND ${GIT_PROGRAM} diff --no-color --name-only --diff-filter=AMCR origin/main HEAD)

execute_process(
  COMMAND
    ${GIT_DIFF_COMMAND}
  WORKING_DIRECTORY
    ${CWD}
  OUTPUT_STRIP_TRAILING_WHITESPACE
  OUTPUT_VARIABLE
    GIT_DIFF
  ERROR_STRIP_TRAILING_WHITESPACE
  ERROR_VARIABLE
    GIT_DIFF_ERROR
  RESULT_VARIABLE
    GIT_DIFF_RESULT
)

if(NOT GIT_DIFF_RESULT EQUAL 0)
  message(WARNING "Command failed: ${GIT_DIFF_COMMAND} ${GIT_DIFF_ERROR}")
  return()
endif()

string(REPLACE "\n" ";" GIT_CHANGED_SOURCES "${GIT_DIFF}")

if(CI)
  set(GIT_CHANGED_SOURCES "${GIT_CHANGED_SOURCES}")
  message(STATUS "Set GIT_CHANGED_SOURCES: ${GIT_CHANGED_SOURCES}")
endif()

list(TRANSFORM GIT_CHANGED_SOURCES PREPEND ${CWD}/)
list(LENGTH GIT_CHANGED_SOURCES GIT_CHANGED_SOURCES_COUNT)
