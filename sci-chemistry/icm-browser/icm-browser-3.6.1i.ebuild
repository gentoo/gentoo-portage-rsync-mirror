# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/icm-browser/icm-browser-3.6.1i.ebuild,v 1.3 2014/09/07 15:44:04 ulm Exp $

EAPI="3"

inherit rpm eutils versionator

MY_PV=$(replace_version_separator 2 '-' )
MY_P="$PN-${MY_PV}"
DESCRIPTION="MolSoft LCC ICM Browser"
SRC_URI="${MY_P}.i386.rpm"
HOMEPAGE="http://www.molsoft.com/icm_browser.html"

LICENSE="MolSoft"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"

DEPEND="!sci-chemistry/icm
	virtual/libstdc++:3.3
	amd64? (
		app-emulation/emul-linux-x86-xlibs
	)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/usr/${PN}-pro-${MY_PV}"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from "
	einfo "${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	rpm_src_unpack
}

src_install () {
	instdir=/opt/icm-browser
	dodir "${instdir}"
	dodir "${instdir}/licenses"
	cp -pPR * "${D}/${instdir}"
	doenvd "${FILESDIR}/90icm-browser" || die
	exeinto ${instdir}
	doexe "${S}/icmbrowserpro" || die
	doexe "${S}/lmhostid" || die
	doexe "${S}/txdoc" || die
	dosym "${instdir}/icmbrowserpro"  /opt/bin/icmbrowserpro || die
	dosym "${instdir}/txdoc"  /opt/bin/txdoc || die
	dosym "${instdir}/lmhostid"  /opt/bin/lmhostid || die
	# make desktop entry
	doicon "${FILESDIR}"/${PN}.xpm
	make_desktop_entry "icmbrowserpro -g" "ICM Browser" ${PN} Chemistry
}

pkg_postinst () {
	einfo
	einfo "Documentation can be found in ${instdir}/man/"
	einfo
	einfo "If you want to upgrade free version of browser to pro version"
	einfo "you should purchaise license from ${HOMEPAGE} and place it to"
	einfo "${instdir}/licenses"
	einfo
}
