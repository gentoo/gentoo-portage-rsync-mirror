# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/whyteboard/whyteboard-0.41.1.ebuild,v 1.5 2015/03/20 16:34:47 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1 multilib

DESCRIPTION="A simple image, PDF and postscript file annotator"
HOMEPAGE="http://code.google.com/p/whyteboard"
SRC_URI="
	http://whyteboard.googlecode.com/files/${P}.tar.gz
	http://dev.gentoo.org/~lxnay/${PN}/${PN}.png"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/wxpython:*[${PYTHON_USEDEP}]
	media-gfx/imagemagick"

src_install() {
	doicon "${DISTDIR}"/${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop

	dodoc CHANGELOG.txt DEVELOPING.txt README.txt TODO.txt

	python_domodule images locale ${PN} ${PN}-help ${PN}.py

	cat >> "${T}/${PN}" <<- EOF
	#!/bin/sh
	exec ${PYTHON} -O "$(python_get_sitedir)/${PN}/${PN}.py"
	EOF
	dobin "${T}/${PN}"

	python_optimize
}

pkg_preinst() {
	echo
	elog "This application is very experimental and some features"
	elog "are not yet implemented, however you can live with it"
	echo
}
