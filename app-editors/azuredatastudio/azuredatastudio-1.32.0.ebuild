# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="Multiplatform Azure Data Studio from Microsoft"
HOMEPAGE="https://docs.microsoft.com/sql/azure-data-studio"
SRC_URI="
	amd64? ( https://sqlopsbuilds.azureedge.net/stable/4a45ba7cf20dd4129f1a08e5e776dfb33e3d1d1e/${PN}-linux-${PV}.tar.gz )
"
S="${WORKDIR}"

SQLTOOLSSERVICE_VERSION="3.0.0-release.121"

RESTRICT="mirror strip bindist"

LICENSE="
	Apache-2.0
	BSD
	BSD-1
	BSD-2
	BSD-4
	CC-BY-4.0
	ISC
	LGPL-2.1+
	Microsoft-vscode
	MIT
	MPL-2.0
	openssl
	PYTHON
	TextMate-bundle
	Unlicense
	UoI-NCSA
	W3C
	azuredatastudio
"
SLOT="0"
KEYWORDS="-* ~amd64"

BDEPEND="dev-util/patchelf"
RDEPEND="
	app-accessibility/at-spi2-atk
	app-crypt/libsecret[crypt]
	dev-libs/nss
	|| ( dev-libs/openssl-compat:1.0.0 =dev-libs/openssl-1.0*:* )
	media-libs/alsa-lib
	media-libs/libpng:0/16
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
"

QA_PREBUILT="
	/opt/azuredatastudio/azuredatastudio
	/opt/azuredatastudio/libEGL.so
	/opt/azuredatastudio/libffmpeg.so
	/opt/azuredatastudio/libGLESv2.so
	/opt/azuredatastudio/libvulkan.so*
	/opt/azuredatastudio/chrome-sandbox
	/opt/azuredatastudio/libvk_swiftshader.so
	/opt/azuredatastudio/swiftshader/libEGL.so
	/opt/azuredatastudio/swiftshader/libGLESv2.so
	/opt/azuredatastudio/resources/app/extensions/*
	/opt/azuredatastudio/resources/app/node_modules.asar.unpacked/*
"

src_install() {
	if use amd64; then
		cd "${WORKDIR}/${PN}-linux-x64" || die
	else
		die "Azure Data Studio only supports amd64"
	fi

	pax-mark m ${PN}
	patchelf --set-rpath "${EPREFIX}/opt/${PN}" resources/app/extensions/mssql/sqltoolsservice/Linux/${SQLTOOLSSERVICE_VERSION}/System.Security.Cryptography.Native.OpenSsl.so || die
	insinto "/opt/${PN}"
	doins -r *
	fperms +x /opt/${PN}/{,bin/}${PN}
	fperms 4711 /opt/${PN}/chrome-sandbox
	fperms 755 /opt/${PN}/resources/app/extensions/git/dist/askpass.sh
	fperms 755 /opt/${PN}/resources/app/extensions/git/dist/askpass-empty.sh
	fperms -R +x /opt/${PN}/resources/app/out/vs/base/node
	fperms +x /opt/${PN}/resources/app/extensions/mssql/sqltoolsservice/Linux/${SQLTOOLSSERVICE_VERSION}/createdump
	fperms +x /opt/${PN}/resources/app/extensions/mssql/sqltoolsservice/Linux/${SQLTOOLSSERVICE_VERSION}/MicrosoftKustoServiceLayer
	fperms +x /opt/${PN}/resources/app/extensions/mssql/sqltoolsservice/Linux/${SQLTOOLSSERVICE_VERSION}/MicrosoftSqlToolsCredentials
	fperms +x /opt/${PN}/resources/app/extensions/mssql/sqltoolsservice/Linux/${SQLTOOLSSERVICE_VERSION}/MicrosoftSqlToolsServiceLayer
	fperms +x /opt/${PN}/resources/app/extensions/mssql/sqltoolsservice/Linux/${SQLTOOLSSERVICE_VERSION}/SqlToolsResourceProviderService
	dosym "../../opt/${PN}/bin/${PN}" "usr/bin/${PN}"
	dosym "../../usr/$(get_libdir)/libssl.so.1.0.0" /opt/${PN}/libssl.so.10
	dosym "../../usr/$(get_libdir)/libcrypto.so.1.0.0" /opt/${PN}/libcrypto.so.10
	domenu "${FILESDIR}/${PN}.desktop"
	newicon "resources/app/resources/linux/code.png" "${PN}.png"
}

pkg_postinst() {
	xdg_pkg_postinst
}
