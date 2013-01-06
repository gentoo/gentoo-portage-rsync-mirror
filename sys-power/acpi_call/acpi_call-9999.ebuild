# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpi_call/acpi_call-9999.ebuild,v 1.4 2012/12/20 04:44:07 ottxor Exp $

EAPI=5

inherit linux-info linux-mod

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/mkottman/acpi_call.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/mkottman/acpi_call/tarball/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A kernel module that enables you to call ACPI methods"
HOMEPAGE="http://github.com/mkottman/acpi_call"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

CONFIG_CHECK="ACPI"
MODULE_NAMES="acpi_call(misc:${S})"
BUILD_TARGETS="default"

src_compile(){
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
