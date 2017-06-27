# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Intel Processor Trace Decoder Library"
HOMEPAGE="https://github.com/01org/processor-trace"
SRC_URI="https://github.com/01org/processor-trace/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/processor-trace-${PV}"
