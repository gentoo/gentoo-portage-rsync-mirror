# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/qxmpp/qxmpp-9999.ebuild,v 1.11 2012/10/14 18:46:13 pinkbyte Exp $

EAPI=4

EGIT_REPO_URI="https://code.google.com/p/qxmpp"

inherit qt4-r2 multilib git-2

DESCRIPTION="A cross-platform C++ XMPP client library based on the Qt framework."
HOMEPAGE="http://code.google.com/p/qxmpp/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug doc test"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	media-libs/speex"
DEPEND="${RDEPEND}
	test? ( x11-libs/qt-test:4 )"

src_prepare(){
	if ! use doc; then
		sed -i \
			-e '/SUBDIRS/s/doc//' \
			-e '/INSTALLS/d' \
			qxmpp.pro || die "sed for removing docs failed"
	fi
	if ! use test; then
		sed -i -e '/SUBDIRS/s/tests//' \
			qxmpp.pro || die "sed for removing tests failed"
	fi
	qt4-r2_src_prepare
}

src_configure(){
	eqmake4 "${S}"/qxmpp.pro "PREFIX=${EPREFIX}/usr" "LIBDIR=$(get_libdir)"
}

src_install() {
	qt4-r2_src_install
	if use doc; then
		# Use proper path for documentation
		mv "${ED}"/usr/share/doc/${PN} "${ED}"/usr/share/doc/${P} || die "doc mv failed"
	fi
}
