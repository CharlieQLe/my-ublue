#!/usr/bin/env bash

set -oue pipefail

rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:charlieqle:rpmspec mutter mutter-common