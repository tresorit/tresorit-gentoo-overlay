# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PV_VERSION="${PV/_p*}"
PV_DATE="${PV##*_p}"

DESCRIPTION="A software reverse engineering (SRE) suite of tools developed by NSA"
HOMEPAGE="https://ghidra-sre.org/ https://github.com/NationalSecurityAgency/ghidra/"
SRC_URI="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${PV_VERSION}_build/ghidra_${PV_VERSION}_PUBLIC_${PV_DATE}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="hidpi"

S="${WORKDIR}/ghidra_${PV_VERSION}_PUBLIC"
QA_PREBUILT="*"

BDEPEND=""
DEPEND=""
RDEPEND="
	>=virtual/jdk-11
"

src_prepare() {
	default

	if use hidpi; then
		sed -i 's/uiScale=1/uiScale=2/' support/launch.properties
	fi
}

src_install() {
	insinto "/opt/${PN}"
	doins -r *

	fperms +x /opt/${PN}/Ghidra/Features/Decompiler/os/linux_x86_64/decompile
	fperms +x /opt/${PN}/Ghidra/Features/Decompiler/os/linux_x86_64/sleigh
	fperms +x /opt/${PN}/ghidraRun
	fperms +x /opt/${PN}/GPL/DemanglerGnu/os/linux_x86_64/demangler_gnu_v*
	fperms +x /opt/${PN}/server/ghidraSvr
	fperms +x /opt/${PN}/server/jaas_external_program.example.sh
	fperms +x /opt/${PN}/server/svrAdmin
	fperms +x /opt/${PN}/server/svrInstall
	fperms +x /opt/${PN}/server/svrUninstall
	fperms +x /opt/${PN}/support/analyzeHeadless
	fperms +x /opt/${PN}/support/buildGhidraJar
	fperms +x /opt/${PN}/support/buildNatives
	fperms +x /opt/${PN}/support/convertStorage
	fperms +x /opt/${PN}/support/ghidraDebug
	fperms +x /opt/${PN}/support/launch.sh
	fperms +x /opt/${PN}/support/launch.sh
	fperms +x /opt/${PN}/support/pythonRun
	fperms +x /opt/${PN}/support/sleigh

	dosym "../../opt/${PN}/ghidraRun" "usr/bin/ghidra-bin"
}
