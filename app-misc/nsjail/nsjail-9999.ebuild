# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 toolchain-funcs

DESCRIPTION="nsjail is a process isolation tool for Linux."
HOMEPAGE="https://nsjail.com/"
EGIT_REPO_URI="https://github.com/google/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/protobuf"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/makefile.patch" )

src_prepare() {
    default
	tc-export CC CXX
}

src_install() {
	dobin nsjail
	dodoc README.md
}

