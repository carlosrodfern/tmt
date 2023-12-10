#!/bin/bash
. /usr/share/beakerlib/beakerlib.sh || exit 1

PROVISION_METHODS=${PROVISION_METHODS:-virtual}

rlJournalStart
    if [[ "$PROVISION_METHODS" =~ virtual ]]; then
        rlPhaseStartSetup
            rlRun "pushd data"
        rlPhaseEnd

        rlPhaseStartTest "Test become=true with umask 0027"
            rlRun "tmt run -rvvv --all"
        rlPhaseEnd

        rlPhaseStartCleanup
            rlRun "popd"
        rlPhaseEnd
    fi
rlJournalEnd
