# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils

DESCRIPTION=".NET Core SDK - binary precompiled for glibc"
HOMEPAGE="https://www.microsoft.com/net/core"
LICENSE="MIT"

SRC_URI="
amd64? ( https://download.visualstudio.microsoft.com/download/pr/498b8b41-7626-435e-bea8-878c39ccbbf3/c8df08e881d1bcf9a49a9ff5367090cc/dotnet-sdk-3.0.100-preview9-014004-linux-x64.tar.gz -> dotnet-sdk-3.0.100-preview9-014004-linux-x64.tar.gz )
"

SLOT="0"
KEYWORDS=""

QA_PREBUILT="*"
RESTRICT="splitdebug"

# The sdk includes the runtime-bin and aspnet-bin so prevent from installing at the same time
# dotnetcore-sdk is the source based build

RDEPEND="
	=dev-dotnet/dotnetcore-sdk-bin-${PV}
	!dev-dotnet/dotnetcore-sdk-bin:0"

S=${WORKDIR}

src_prepare() {
	default
	find . -maxdepth 1 -type d ! -name . -exec rm -rf {} \; || die
}

src_install() {
	local dest="opt/dotnet_core"
	dodir "${dest}"

	local ddest="${D}${dest}"
	cp -a "${S}"/* "${ddest}/" || die

	dodir /usr/bin
	cat <<-EOF >"${D}"/usr/bin/dotnet || die
		#!/bin/sh
		DOTNET_HOME="/${dest}" \\
		DOTNET_ROOT="/${dest}" \\
		DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \\
		DOTNET_CLI_TELEMETRY_OPTOUT=true \\
		exec /${dest}/dotnet "\$@"
	EOF
	fperms +x /usr/bin/dotnet
}
