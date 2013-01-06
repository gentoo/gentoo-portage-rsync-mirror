# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-5.51.6.ebuild,v 1.1 2012/09/25 18:54:58 pinkbyte Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils flag-o-matic python

MY_P=${P/_beta/BETA}

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://nmap.org/"
SRC_URI="http://nmap.org/dist/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="gtk lua ssl"

DEPEND="dev-libs/libpcre
	net-libs/libpcap
	gtk? ( >=x11-libs/gtk+-2.6:2
		   >=dev-python/pygtk-2.6
		   || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 )
		 )
	lua? ( >=dev-lang/lua-5.1.4-r1[deprecated] )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.75-include.patch
	epatch "${FILESDIR}"/${PN}-4.75-nolua.patch
	epatch "${FILESDIR}"/${PN}-5.10_beta1-string.patch
	epatch "${FILESDIR}"/${PN}-5.21-python.patch
	epatch "${FILESDIR}"/${PN}-5.51-su-to-zenmap-fix.patch
	sed -i -e 's/-m 755 -s ncat/-m 755 ncat/' ncat/Makefile.in

	# Fix desktop files wrt bug #432714
	sed -i -e '/^Encoding/d' zenmap/install_scripts/unix/zenmap.desktop
	sed -i -e '/^Encoding/d' zenmap/install_scripts/unix/zenmap-root.desktop
	sed -i -e 's/Categories=Application;Network;Security/Categories=Network;System;Security;/' zenmap/install_scripts/unix/zenmap.desktop
	sed -i -e 's/Categories=Application;Network;Security/Categories=Network;System;Security;/' zenmap/install_scripts/unix/zenmap-root.desktop
}

src_configure() {
	# The bundled libdnet is incompatible with the version available in the
	# tree, so we cannot use the system library here.
	econf --with-libdnet=included \
		$(use_with gtk zenmap) \
		$(use_with lua liblua) \
		$(use_with ssl openssl)
}

src_install() {
	LC_ALL=C emake DESTDIR="${D}" -j1 STRIP=: nmapdatadir="${EPREFIX}"/usr/share/nmap install || die
	dodoc CHANGELOG HACKING docs/README docs/*.txt || die

	use gtk && doicon "${FILESDIR}/nmap-logo-64.png"
}

pkg_postinst() {
	if use gtk; then
		python_mod_optimize radialnet zenmapCore zenmapGUI
	fi
}

pkg_postrm() {
	if use gtk; then
		python_mod_cleanup radialnet zenmapCore zenmapGUI
	fi
}
