# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/whyteboard/whyteboard-0.41.1.ebuild,v 1.3 2012/09/05 08:13:21 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2" # Upstream doesn't support Python 3.x

inherit eutils python multilib

DESCRIPTION="A simple image, PDF and postscript file annotator."
LICENSE="ISC"
SLOT="0"
IUSE=""

HOMEPAGE="http://code.google.com/p/whyteboard"
SRC_URI="http://whyteboard.googlecode.com/files/${P}.tar.gz http://dev.gentoo.org/~lxnay/${PN}/${PN}.png"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}
	dev-python/wxpython
	media-gfx/imagemagick"

src_install() {
	dodir /usr/bin
	dodir /usr/share/applications
	dodir /usr/share/pixmaps

	insinto /usr/share/pixmaps
	doins "${DISTDIR}/${PN}.png" || die
	domenu "${FILESDIR}/${PN}.desktop" || die

	dodoc CHANGELOG.txt DEVELOPING.txt README.txt TODO.txt || die

	local appdir="$(python_get_sitedir)/${PN}"
	dodir "${appdir}"
	insinto "${appdir}"
	doins -r images 'locale' "${PN}" "${PN}-help" "${PN}.py" || die

	cat >> "${T}/${PN}" <<- EOF
	#!/bin/sh
	exec $(PYTHON) -O "$(python_get_sitedir)/${PN}/${PN}.py"
	EOF
	exeinto /usr/bin
	doexe "${T}/${PN}" || die
}

pkg_preinst() {
	echo
	elog "This application is very experimental and some features"
	elog "are not yet implemented, however you can live with it"
	echo
}
