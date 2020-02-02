# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A size profiler for binaries"
HOMEPAGE="https://github.com/google/${PN}"
SRC_URI="https://github.com/google/${PN}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_install() {
	pushd "${BUILD_DIR}"
	dobin "${PN}"
	popd
	einstalldocs
}
