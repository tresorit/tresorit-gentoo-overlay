# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Intel Processor Trace Decoder Library"
HOMEPAGE="https://github.com/intel/libipt"
SRC_URI="https://github.com/intel/libipt/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/libipt-${PV}"
