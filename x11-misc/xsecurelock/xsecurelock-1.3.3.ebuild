# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="X11 screen lock utility with security in mind "
HOMEPAGE="https://github.com/google/xsecurelock"
SRC_URI="https://github.com/google/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="Apache"
SLOT="0"
KEYWORDS="amd64"
IUSE="+xscreensaver"

DEPEND="
	sys-libs/pam
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXmu
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libXxf86misc
	xscreensaver? ( x11-misc/xscreensaver )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local myeconfargs=(
			--prefix=/usr
			--with-default-auth-module=auth_x11
			--with-default-authproto-module=authproto_pam
			--without-htpasswd
			--without-mplayer
			--without-mpv
			--without-pamtester
			--without-pandoc
			--with-pam-service-name=system-auth
	)
	if use xscreensaver; then
		myeconfargs+=(
			--with-default-saver-module=saver_xscreensaver
			--with-xscreensaver=/usr/lib64/misc/xscreensaver
		)
	else
		myeconfargs+=(
			--with-default-saver-module=saver_blank
			--without-xscreensaver
		)
	fi
	econf "${myeconfargs[@]}"
}

