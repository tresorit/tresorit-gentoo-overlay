# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="SqlPackage"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage"

LICENSE="sqlserver"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="splitdebug"
PROPERTIES="live"

RDEPEND="
	app-crypt/mit-krb5
	dev-libs/icu
	|| ( dev-libs/openssl dev-libs/openssl-compat:1.0.0 )
	dev-util/lldb
	dev-util/lttng-ust
	net-misc/curl
	sys-apps/lsb-release
	sys-devel/llvm
	sys-libs/libunwind
	sys-libs/zlib"

S="${WORKDIR}"
QA_PREBUILT="*"

src_unpack() {
	wget -O $P.zip https://aka.ms/sqlpackage-linux || die "Download failed"
	unpack_zip $P.zip
}

src_install() {
	insinto "/opt/${PN}"
	doins -r *
	fperms +x /opt/${PN}/${PN}
	dosym "../../opt/${PN}/${PN}" "usr/bin/${PN}"
}
