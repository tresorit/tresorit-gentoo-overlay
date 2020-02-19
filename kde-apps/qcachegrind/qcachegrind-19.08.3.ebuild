# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_NAME="kcachegrind"
inherit eutils qmake-utils kde.org

DESCRIPTION="qcachegrind (part of kcachegrind)"
HOMEPAGE="https://kde.org/applications/development/org.kde.kcachegrind
https://kcachegrind.github.io/html/Home.html"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="amd64"

S="${WORKDIR}/${KDE_ORG_NAME}-${PV}"

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
