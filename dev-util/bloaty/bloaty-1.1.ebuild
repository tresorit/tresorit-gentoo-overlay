# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A size profiler for binaries"
HOMEPAGE="https://github.com/google/${PN}"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/${PN}"
else
	SRC_URI="https://github.com/google/${PN}/releases/download/v${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64"
fi

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	dev-libs/capstone:=
	dev-libs/protobuf:=
	dev-libs/re2:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.1-staticlibrary.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBLOATY_ENABLE_CMAKETARGETS=OFF
		-DCMAKE_SKIP_RPATH=ON
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
