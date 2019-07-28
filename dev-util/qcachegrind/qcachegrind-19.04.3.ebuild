# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils qmake-utils

DESCRIPTION="qcachegrind (part of kcachegrind)"
HOMEPAGE="https://kde.org/applications/development/kcachegrind
https://kcachegrind.github.io/html/Home.html"
SRC_URI="https://download.kde.org/stable/applications/${PV}/src/kcachegrind-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/kcachegrind-${PV}"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5[gif,jpeg,png,xcb]
"
RDEPEND="${DEPEND}
	media-gfx/graphviz
"
BDEPEND="
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"

src_configure() {
	cd qcachegrind || die
	eqmake5 \
			PREFIX="${D}/usr" \
			GIT_DESCRIBE="${PV}"
}

src_compile() {
	cd qcachegrind || die
	emake
}

src_install() {
	cd qcachegrind || die
	dodir /usr/bin
    insinto /usr/bin
    insopts -m 755
    doins qcachegrind || die
}
