# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemulator/qemulator-0.5.ebuild,v 1.4 2010/01/05 12:58:43 fauli Exp $

EAPI=2

inherit eutils python

MY_PN="${PN/q/Q}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A gtk/glade front-end for Qemu"
HOMEPAGE="http://qemulator.createweb.de/"
SRC_URI="http://qemulator.createweb.de/phocadownload/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/pygtk-2.8.6
		 || ( >=app-emulation/qemu-softmmu-0.8.1 app-emulation/qemu app-emulation/qemu-kvm )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	#for good directory
	epatch "${FILESDIR}"/basedir.patch
}

src_install() {
	#INSTDIR="/usr/"
	einfo "Installing Qemulator..."
	#dodir ${INSTDIR}
	#mv ${WORKDIR}/${MY_P}/usr/* ${D}${INSTDIR}
	dobin usr/local/bin/*
	insinto /usr/lib/${PN}
	doins -r usr/local/lib/${PN}/*
	insinto /usr/share
	doins -r usr/local/share/*
	dodoc TRANSLATION README
}
