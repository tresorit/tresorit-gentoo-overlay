# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_NAME="kcachegrind"
QTMIN=5.15.2
inherit qmake-utils kde.org

DESCRIPTION="Frontend for Cachegrind by KDE (Qt-only version)"
HOMEPAGE="https://apps.kde.org/en/kcachegrind
https://kcachegrind.github.io/html/Home.html"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="amd64 arm64 ~riscv ~x86"

S="${WORKDIR}/${KDE_ORG_NAME}-${PV}"

BDEPEND="
	>=dev-qt/linguist-tools-${QTMIN}:5
	virtual/pkgconfig
"
DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5[gif,jpeg,png,X]
	>=dev-qt/qtwidgets-${QTMIN}:5[png,X]
"
RDEPEND="${DEPEND}
	media-gfx/graphviz
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
