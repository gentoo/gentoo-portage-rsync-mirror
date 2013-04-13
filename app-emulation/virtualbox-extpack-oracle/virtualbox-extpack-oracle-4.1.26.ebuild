# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-extpack-oracle/virtualbox-extpack-oracle-4.1.26.ebuild,v 1.1 2013/04/13 20:32:41 polynomial-c Exp $

EAPI=2

inherit eutils multilib

MY_BUILD="84997"
MY_PN="Oracle_VM_VirtualBox_Extension_Pack"
MY_P="${MY_PN}-${PV}-${MY_BUILD}"

DESCRIPTION="PUEL extensions for VirtualBox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.vbox-extpack -> ${MY_P}.tar.gz"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="~app-emulation/virtualbox-${PV}"

QA_PREBUILT="/usr/$(get_libdir)/virtualbox/ExtensionPacks/${MY_PN}/.*"

src_install() {
	insinto /usr/$(get_libdir)/virtualbox/ExtensionPacks/${MY_PN}
	doins -r linux.${ARCH}
	doins ExtPack* PXE-Intel.rom
}
