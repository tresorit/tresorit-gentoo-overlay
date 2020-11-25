# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Intel Processor Trace Decoder Library"
HOMEPAGE="https://github.com/intel/libipt"
SRC_URI="https://github.com/intel/libipt/archive/v${PV}.tar.gz -> libipt-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0/2"
KEYWORDS="amd64"
