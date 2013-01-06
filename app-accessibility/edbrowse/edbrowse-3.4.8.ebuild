# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/edbrowse/edbrowse-3.4.8.ebuild,v 1.2 2012/06/19 17:45:19 axs Exp $

EAPI="4"
inherit eutils

DESCRIPTION="editor, browser, and mail client using the /bin/ed interface"
HOMEPAGE="http://the-brannons.com/edbrowse/"
SRC_URI="http://the-brannons.com/${PN}/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_fr odbc"
COMMON_DEPEND=">=dev-lang/spidermonkey-1.8.5
	>=sys-libs/readline-6.0
	>=net-misc/curl-7.17.0
	>=dev-libs/libpcre-7.8
	>=dev-libs/openssl-0.9.8j
	odbc? ( dev-db/unixODBC )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	app-arch/unzip"
RDEPEND="${COMMON_DEPEND}"

src_compile() {
	local jslib="-lmozjs185"
	local jscppflags="-DXP_UNIX -DX86_LINUX -I/usr/include/js"
	if has_version ~dev-lang/spidermonkey-1.8.7 ; then
		jscppflags=$(pkg-config --cflags mozjs187)
		jslib=$(pkg-config --libs mozjs187)
	fi
	emake -j1 prefix=/usr JSLIB="${jslib}" JS_CPPFLAGS="${jscppflags}" STRIP=''
	if use odbc; then
		# Top-level makefile doesn't have this target.
		cd src
		emake -j1 prefix=/usr STRIP='' edbrowseodbc
		cd ..
	fi
}

src_install() {
	cd src
	emake -j1 prefix=/usr DESTDIR="${D}" install
	if use odbc; then
		dobin edbrowseodbc
	fi
	cd ..
	dodoc CHANGES README todo
	cd doc
	dobin setup.ebrc
	dohtml usersguide.html philosophy.html
	dodoc sample.ebrc
	if use linguas_fr; then
		dohtml usersguide_fr.html philosophy_fr.html
		dodoc sample_fr.ebrc
	fi
}
