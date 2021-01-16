# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="case insensitive on purpose file system"
HOMEPAGE="http://brain-dump.org/projects/$PN"
SRC_URI="http://brain-dump.org/projects/$PN/$P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	sys-fs/fuse:0=
	sys-apps/attr
	dev-libs/icu:=
"
RDEPEND="$DEPEND"

PATCHES=(
	"${FILESDIR}/${PN}.patch"
)

src_compile() {
	emake CFLAGS_UNICODE='${CFLAGS_ICU}' LDFLAGS_UNICODE='${LDFLAGS_ICU}' || die
}

src_install() {
	dobin "${PN}" || die
}
