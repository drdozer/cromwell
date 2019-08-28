#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
# import in shellcheck / CI / IntelliJ compatible ways
# shellcheck source=/dev/null
source "${BASH_SOURCE%/*}/test.inc.sh" || source test.inc.sh

cromwell::build::setup_common_environment

cromwell::build::assemble_jars

cat /proc/cpuinfo

java -version

java -jar $CROMWELL_BUILD_CROMWELL_JAR run ./centaur/src/main/resources/standardTestCases/hello/hello.wdl --inputs ./centaur/src/main/resources/standardTestCases/hello/hello.inputs > console_output.txt

grep -q "terminal state: WorkflowSucceededState" console_output.txt
grep -q "\"wf_hello.hello.salutation\": \"Hello m'Lord!\"" console_output.txt
