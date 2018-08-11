# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="case insensitive on purpose file system"
HOMEPAGE="http://brain-dump.org/projects/$PN"
SRC_URI="http://brain-dump.org/projects/$PN/$P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
    sys-fs/fuse
    sys-apps/attr
    dev-libs/glib:2
"
RDEPEND="$DEPEND"

src_prepare() {
	default
	sed -i "s:-O[s0-9]::g" config.mk || die
}

src_compile() {
	emake CFLAGS_UNICODE='${CFLAGS_GLIB}' LDFLAGS_UNICODE='${LDFLAGS_GLIB}' || die
}

src_install() {
	dobin "${PN}" || die
}
