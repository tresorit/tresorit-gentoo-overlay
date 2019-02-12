# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="pbzx stream parser"
HOMEPAGE="https://github.com/NiklasRosenstein/pbzx"
SRC_URI="https://github.com/NiklasRosenstein/pbzx/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	app-arch/xar
	app-arch/xz-utils
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	$(tc-getCC) ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -o ${PN} ${PN}.c -lxar -llzma || die
}

src_install() {
	dobin ${PN}
}
