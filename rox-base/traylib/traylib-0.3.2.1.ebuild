# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/traylib/traylib-0.3.2.1.ebuild,v 1.9 2014/08/10 20:33:07 slyfox Exp $

PYTHON_DEPEND="2:2.5"
inherit python eutils multilib

MY_PN="TrayLib"
DESCRIPTION="TrayLib is a library for tray-based rox panel applets"
HOMEPAGE="http://rox4debian.berlios.de"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/libs/${MY_PN}-${PV}.tgz"

RDEPEND=">=rox-base/rox-lib-1.9.6
	!<rox-base/tasktray-0.7
	!<rox-base/devtray-0.4.1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

src_install() {
	local baselibdir="/usr/$(get_libdir)"
	dodir "${baselibdir}"
	cp -r ${MY_PN}/ "${D}${baselibdir}/${MY_PN}"
	dodir /usr/share/doc/
	dosym ${baselibdir}/${MY_PN}/Help /usr/share/doc/${P}
}

pkg_postinst() {
	local baselibdir="/usr/$(get_libdir)"
	python_mod_optimize "${baselibdir}/${MY_PN}/"
}

pkg_postrm() {
	local baselibdir="/usr/$(get_libdir)"
	python_mod_cleanup "${baselibdir}/${MY_PN}/"
}
