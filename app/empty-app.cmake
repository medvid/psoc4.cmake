project(empty-app)

psoc4_load_application(
  NAME mtb-example-psoc4-empty-app
  VERSION 2.0.0
)
psoc4_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
