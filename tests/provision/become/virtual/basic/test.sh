#!/bin/bash
. /usr/share/beakerlib/beakerlib.sh || exit 1

PROVISION_METHODS=${PROVISION_METHODS:-virtual}

rlJournalStart
    if [[ "$PROVISION_METHODS" =~ virtual ]]; then
        rlPhaseStartSetup
            rlRun "pushd data"
        rlPhaseEnd

        rlPhaseStartTest "Virtual, test with become=true"
            rlRun "tmt run -rvvv plan --name /test/root"
        rlPhaseEnd

        rlPhaseStartTest "Virtual, test with become=false"
            rlRun "tmt run -rvvv plan --name /test/user"
        rlPhaseEnd

        rlPhaseStartTest "Virtual, prepare/finish inline with become=true"
            rlRun "tmt run -rvvv plan --name /prepare-finish/root/inline"
        rlPhaseEnd

        rlPhaseStartTest "Virtual, prepare/finish inline with become=false"
            rlRun "tmt run -rvvv plan --name /prepare-finish/user/inline"
        rlPhaseEnd

        rlPhaseStartTest "Virtual, prepare/finish scripts with become=true"
            rlRun "tmt run -rvvv plan --name /prepare-finish/root/scripts"
        rlPhaseEnd

        rlPhaseStartTest "Virtual, prepare/finish scripts with become=false"
            rlRun "tmt run -rvvv plan --name /prepare-finish/user/scripts"
        rlPhaseEnd

        rlPhaseStartCleanup
            rlRun "popd"
        rlPhaseEnd
    fi
rlJournalEnd
