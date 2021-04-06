# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_REMOVE_MODULES_LIST=( FindFreetype )
LUA_COMPAT=( luajit )
# Does not work with 3.8+ https://bugs.gentoo.org/754006
PYTHON_COMPAT=( python3_7 )

OBS_BROWSER_COMMIT="200f34d94c75a681d9c609850029188f246c13f5"
CEF_DIR="cef_binary_4280_linux64"

inherit cmake lua-single python-single-r1 xdg-utils

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/obsproject/obs-studio.git"
	EGIT_SUBMODULES=( "plugins/obs-browser" )
else
	SRC_URI="https://github.com/obsproject/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" browser? ( https://github.com/obsproject/obs-browser/archive/${OBS_BROWSER_COMMIT}.tar.gz -> obs-browser-${OBS_BROWSER_COMMIT}.tar.gz )"
	KEYWORDS="~amd64 ~ppc64 ~x86"
fi
SRC_URI+=" browser? ( https://cdn-fastly.obsproject.com/downloads/${CEF_DIR}.tar.bz2 )"

DESCRIPTION="Software for Recording and Streaming Live Video Content"
HOMEPAGE="https://obsproject.com"

LICENSE="GPL-2"
SLOT="0"
IUSE="+alsa browser fdk imagemagick jack lua nvenc pulseaudio python speex +ssl truetype v4l vlc"
REQUIRED_USE="
	browser? ( || ( alsa pulseaudio ) )
	lua? ( ${LUA_REQUIRED_USE} )
	python? ( ${PYTHON_REQUIRED_USE} )
"

BDEPEND="
	lua? ( dev-lang/swig )
	python? ( dev-lang/swig )
"
DEPEND="
	>=dev-libs/jansson-2.5
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	media-libs/x264:=
	media-video/ffmpeg:=[x264]
	net-misc/curl
	sys-apps/dbus
	sys-libs/zlib
	virtual/udev
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXfixes
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libxcb
	alsa? ( media-libs/alsa-lib )
	browser? (
		app-accessibility/at-spi2-atk
		dev-libs/atk
		dev-libs/expat
		dev-libs/glib
		dev-libs/nspr
		dev-libs/nss
		media-libs/fontconfig
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		x11-libs/libXtst
	)
	fdk? ( media-libs/fdk-aac:= )
	imagemagick? ( media-gfx/imagemagick:= )
	jack? ( virtual/jack )
	lua? ( ${LUA_DEPS} )
	nvenc? ( >=media-video/ffmpeg-4[video_cards_nvidia] )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( ${PYTHON_DEPS} )
	speex? ( media-libs/speexdsp )
	ssl? ( net-libs/mbedtls:= )
	truetype? (
		media-libs/fontconfig
		media-libs/freetype
	)
	v4l? ( media-libs/libv4l )
	vlc? ( media-video/vlc:= )
"
RDEPEND="${DEPEND}"

QA_PREBUILT="
	/usr/lib*/obs-plugins/chrome-sandbox
	/usr/lib*/obs-plugins/libcef.so
	/usr/lib*/obs-plugins/libEGL.so
	/usr/lib*/obs-plugins/libGLESv2.so
	/usr/lib*/obs-plugins/swiftshader/libEGL.so
	/usr/lib*/obs-plugins/swiftshader/libGLESv2.so
"

pkg_setup() {
	use lua && lua-single_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_unpack() {
	default
	if [[ ${PV} != *9999 ]]; then
		if use browser; then
			rm -d "${P}/plugins/obs-browser" || die
			mv "obs-browser-${OBS_BROWSER_COMMIT}" "${P}/plugins/obs-browser" || die
		fi
	else
		git-r3_src_unpack
	fi
}

src_configure() {
	local libdir=$(get_libdir)
	local mycmakeargs=(
		-DBUILD_BROWSER=$(usex browser)
		-DDISABLE_ALSA=$(usex !alsa)
		-DDISABLE_FREETYPE=$(usex !truetype)
		-DDISABLE_JACK=$(usex !jack)
		-DDISABLE_LIBFDK=$(usex !fdk)
		-DDISABLE_PULSEAUDIO=$(usex !pulseaudio)
		-DDISABLE_SPEEXDSP=$(usex !speex)
		-DDISABLE_V4L2=$(usex !v4l)
		-DDISABLE_VLC=$(usex !vlc)
		-DLIBOBS_PREFER_IMAGEMAGICK=$(usex imagemagick)
		-DOBS_MULTIARCH_SUFFIX=${libdir#lib}
		-DUNIX_STRUCTURE=1
		-DWITH_RTMPS=$(usex ssl)
	)

	if [[ ${PV} != *9999 ]]; then
		mycmakeargs+=(
			-DOBS_VERSION_OVERRIDE=${PV}
		)
	fi

	if use browser; then
		mycmakeargs+=(
			-DCEF_ROOT_DIR="../${CEF_DIR}"
		)
	fi

	if use lua || use python; then
		mycmakeargs+=(
			-DDISABLE_LUA=$(usex !lua)
			-DDISABLE_PYTHON=$(usex !python)
			-DENABLE_SCRIPTING=yes
		)
	else
		mycmakeargs+=( -DENABLE_SCRIPTING=no )
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	#external plugins may need some things not installed by default, install them here
	insinto /usr/include/obs/UI/obs-frontend-api
	doins UI/obs-frontend-api/obs-frontend-api.h
}

pkg_postinst() {
	xdg_icon_cache_update

	if ! use alsa && ! use pulseaudio; then
		elog
		elog "For the audio capture features to be available,"
		elog "either the 'alsa' or the 'pulseaudio' USE-flag needs to"
		elog "be enabled."
		elog
	fi

	if ! has_version "sys-apps/dbus"; then
		elog
		elog "The 'sys-apps/dbus' package is not installed, but"
		elog "could be used for disabling hibernating, screensaving,"
		elog "and sleeping.  Where it is not installed,"
		elog "'xdg-screensaver reset' is used instead"
		elog "(if 'x11-misc/xdg-utils' is installed)."
		elog
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
}