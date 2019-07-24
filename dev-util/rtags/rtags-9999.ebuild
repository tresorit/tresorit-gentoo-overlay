# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://www.rtags.net/"
# The github zip does not contain the submodule(s) required to build the
# project, so use the git version and the git-r3 eclass instead
SRC_URI=""
EGIT_REPO_URI="https://github.com/Andersbakken/rtags.git"
EGIT_BRANCH="master"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-devel/clang:=
	sys-libs/ncurses:0
	sys-libs/zlib
	dev-libs/openssl:0="
RDEPEND="${DEPEND}"
