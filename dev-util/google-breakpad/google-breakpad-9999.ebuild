# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="Google Breakpad: generate and investigate crash dumps"
HOMEPAGE="https://chromium.googlesource.com/breakpad/breakpad"
SRC_URI=""
EGIT_REPO_URI="https://chromium.googlesource.com/breakpad/breakpad"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack

	# required submodule, clone manually to avoid the usage of "depot_tools"
	git clone https://chromium.googlesource.com/linux-syscall-support "${S}/src/third_party/lss"
}
