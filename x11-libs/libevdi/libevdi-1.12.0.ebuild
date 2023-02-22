# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} != *9999* ]]; then
	MY_PN="evdi"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/DisplayLink/evdi/archive/v${PV}.tar.gz  -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_P}"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DisplayLink/evdi.git"
fi

S="${S}/library"

DESCRIPTION="Library for managing screens"
HOMEPAGE="https://github.com/DisplayLink/evdi"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="x11-drivers/evdi"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	emake install DESTDIR="${D}" LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	doheader "${S}/evdi_lib.h"
}
