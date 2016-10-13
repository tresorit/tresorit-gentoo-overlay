# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="qcachegrind (part of kcachegrind)"
HOMEPAGE="https://kcachegrind.github.io"
SRC_URI="http://download.kde.org/stable/applications/${PV}/src/kcachegrind-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5[gif,jpeg,png,xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"

src_configure() {
	cd qcachegrind || die
	eqmake5 \
			PREFIX="${D}/usr" \
			GIT_DESCRIBE="${PV}"
}
