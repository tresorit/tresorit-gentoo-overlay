# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MULTILIB_COMPAT=( abi_x86_64 )

inherit pax-utils rpm multilib-build xdg-utils

DESCRIPTION="Microsoft Teams for Linux is your chat-centered workspace in Office 365"
HOMEPAGE="https://aka.ms/microsoftteams"
SRC_URI="https://packages.microsoft.com/yumrepos/ms-teams/${PN}-${PV}-1.x86_64.rpm"

LICENSE="no-source-code MIT MIT-with-advertising BSD-1 BSD-2 BSD Apache-2.0 Boost-1.0 ISC CC-BY-SA-3.0 CC0-1.0 openssl ZLIB APSL-2 icu Artistic-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pax_kernel"

S="${WORKDIR}"
QA_PREBUILT=opt/teams/teams
QA_TEXTRELS=opt/teams/resources/app.asar.unpacked/node_modules/slimcore/bin/slimcore.node
QA_EXECSTACK=opt/teams/resources/app.asar.unpacked/node_modules/slimcore/bin/slimcore.node
RESTRICT="mirror bindist strip" #299368


RDEPEND="
	app-crypt/libsecret[${MULTILIB_USEDEP}]
	dev-libs/atk[${MULTILIB_USEDEP}]
	dev-libs/expat[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	gnome-base/gconf:2[${MULTILIB_USEDEP}]
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/libv4l[${MULTILIB_USEDEP}]
	net-print/cups[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	sys-devel/gcc[cxx]
	virtual/ttf-fonts
	x11-libs/cairo[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:2[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXcursor[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libXrender[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/libxcb[${MULTILIB_USEDEP}]
	x11-libs/libxkbfile[${MULTILIB_USEDEP}]
	x11-libs/pango[${MULTILIB_USEDEP}]"

src_unpack() {
	rpm_src_unpack ${A}
}

src_prepare() {
	default
	sed -e "s!^TEAMS_PATH=.*!TEAMS_PATH=${EPREFIX}/opt/teams/teams!" \
		-i usr/bin/teams || die
	sed -e "s!^Exec=/usr/bin/teams!Exec=${EPREFIX}/opt/bin/teams!" \
		-e "s!^Categories=.*!Categories=Network;InstantMessaging;AudioVideo;!" \
		-e "/OnlyShowIn=.*/d" \
		-i usr/share/applications/teams.desktop || die
}

src_install() {
	insinto /opt/teams/locales
	doins usr/share/teams/locales/*.pak

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/@microsoft/fasttext-languagedetector/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/@microsoft/fasttext-languagedetector/build/Release/fastText-languagedetector.node
	insinto /opt/teams/resources/app.asar.unpacked/node_modules/@microsoft/fasttext-languagedetector/models
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/@microsoft/fasttext-languagedetector/models/*.ftz

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/@msteams/electron-modules-package-utils/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/@msteams/electron-modules-package-utils/build/Release/package-utils.node
	insinto /opt/teams/resources/app.asar.unpacked/node_modules/@msteams/node-locale-info-provider/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/@msteams/node-locale-info-provider/build/Release/node-locale-info-provider.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/modern-osutils/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/modern-osutils/build/Release/modern-osutils.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/media-hid/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/media-hid/build/Release/media-hid.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/native-utils/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/native-utils/build/Release/native-utils.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/node-spellcheckr/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/node-spellcheckr/build/Release/spellchecker.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/keyboard-layout/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/keyboard-layout/build/Release/keyboard-layout-manager.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/keytar3/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/keytar3/build/Release/keytar.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/keytar4/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/keytar4/build/Release/keytar.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/slimcore/bin
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/slimcore/bin/*.node

	insinto /opt/teams/resources/app.asar.unpacked/node_modules/v8-profiler-torycl/build/Release
	doins usr/share/teams/resources/app.asar.unpacked/node_modules/v8-profiler-torycl/build/Release/profiler.node

	insinto /opt/teams/resources
	doins usr/share/teams/resources/*.asar

	insinto /opt/teams/resources/locales
	doins usr/share/teams/resources/locales/*.json

	insinto /opt/teams/resources/assets
	doins -r usr/share/teams/resources/assets/*

	insinto /opt/teams
	doins usr/share/teams/*.pak
	doins usr/share/teams/*.bin
	doins usr/share/teams/*.dat
	exeinto /opt/teams
	doexe usr/share/teams/*.so
	doexe usr/share/teams/teams

	exeinto /opt/teams/swiftshader
	doexe usr/share/teams/swiftshader/*.so

	into /opt
	dobin usr/bin/teams

	dodoc usr/share/teams/*.html
	#dodoc -r usr/share/doc/teams/.
	# symlink required for the "Help->3rd Party Notes" menu entry  (otherwise frozen skype -> xdg-open)
	#dosym ${P} usr/share/doc/teams

	# compat symlink for teams bin autocreate autostart desktop file
	dosym ../../opt/bin/teams usr/bin/teams

	doicon usr/share/pixmaps/teams.png

	#local res
	# no 1024 at the moment
	#for res in 16 32 256 512; do
	#	newicon -s ${res} usr/share/icons/hicolor/${res}x${res}/apps/teams.png teams.png
	#done

	domenu usr/share/applications/teams.desktop

	if use pax_kernel; then
		pax-mark -Cm "${ED%/}"/opt/teams/teams
		pax-mark -Cm "${ED%/}"/opt/teams/resources/app.asar.unpacked/node_modules/slimcore/bin/slimcore.node
		eqawarn "You have set USE=pax_kernel meaning that you intend to run"
		eqawarn "${PN} under a PaX enabled kernel. To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage! If"
		eqawarn "you suspect that ${PN} is being broken by this modification,"
		eqawarn "please open a bug."
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
