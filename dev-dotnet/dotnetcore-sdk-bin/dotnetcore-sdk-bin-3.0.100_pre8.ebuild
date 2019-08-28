# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils

DESCRIPTION=".NET Core SDK - binary precompiled for glibc"
HOMEPAGE="https://www.microsoft.com/net/core"
LICENSE="MIT"

SRC_URI="
amd64? ( https://download.visualstudio.microsoft.com/download/pr/a0e368ac-7161-4bde-a139-1a3ef5a82bbe/439cdbb58950916d3718771c5d986c35/dotnet-sdk-3.0.100-preview8-013656-linux-x64.tar.gz -> dotnet-sdk-3.0.100-preview8-013656-linux-x64.tar.gz )
"

SLOT="3.0"
KEYWORDS=""

QA_PREBUILT="*"
RESTRICT="splitdebug"

# The sdk includes the runtime-bin and aspnet-bin so prevent from installing at the same time
# dotnetcore-sdk is the source based build

RDEPEND="
	app-eselect/eselect-dotnet
	>=sys-apps/lsb-release-1.4
	>=sys-devel/llvm-4.0
	>=dev-util/lldb-4.0
	>=sys-libs/libunwind-1.1-r1
	>=dev-libs/icu-57.1
	>=dev-util/lttng-ust-2.8.1
	>=dev-libs/openssl-1.0.2h-r2
	>=net-misc/curl-7.49.0
	>=app-crypt/mit-krb5-1.14.2
	>=sys-libs/zlib-1.2.8-r1
	!dev-dotnet/dotnetcore-sdk
	!dev-dotnet/dotnetcore-sdk-bin:0
	!dev-dotnet/dotnetcore-runtime-bin
	!dev-dotnet/dotnetcore-aspnet-bin"

S=${WORKDIR}

src_prepare() {
	default
	mkdir -p root/$SLOT || die
	find . -maxdepth 1 -type f -exec mv {} root/$SLOT \; || die
	find . -maxdepth 1 ! -name root ! -name . -exec ln -s ../../{} root/$SLOT/{} \; || die
}

src_install() {
	local dest="opt/dotnet_core"
	dodir "${dest}"

	local ddest="${D}${dest}"
	cp -a "${S}"/* "${ddest}/" || die

	dodir /usr/bin
	cat <<-EOF >"${D}"/usr/bin/dotnet-${SLOT} || die
		#!/bin/sh
		DOTNET_HOME="/${dest}/root/${SLOT}" \\
		DOTNET_ROOT="/${dest}/root/${SLOT}" \\
		DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \\
		DOTNET_CLI_TELEMETRY_OPTOUT=true \\
		exec /${dest}/root/${SLOT}/dotnet "\$@"
	EOF
	fperms +x /usr/bin/dotnet-${SLOT}
}

pkg_postinst() {
	eselect dotnet update ifunset
}

pkg_postrm() {
	eselect dotnet update ifunset
}
