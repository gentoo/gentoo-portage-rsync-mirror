# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpint/cpint-2.5.3.ebuild,v 1.2 2008/01/11 07:16:12 vapier Exp $

inherit linux-info eutils

MY_PV=${PV//./}

DESCRIPTION="Linux/390 Interface to z/VM's Control Program"
HOMEPAGE="http://linuxvm.org/Patches/index.html"
SRC_URI="http://linuxvm.org/Patches/s390/${PN}${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="s390"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-prototypes.patch
	epatch "${FILESDIR}"/${P}-kernel.patch

	# the makefile uses this variable
	export KERNEL_DIR
}

src_install() {
	emake install prefix="${D}" || die
	dodoc ChangeLog HOW-TO
}
