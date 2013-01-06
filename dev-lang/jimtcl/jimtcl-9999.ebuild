# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/jimtcl/jimtcl-9999.ebuild,v 1.6 2012/08/17 22:23:50 hwoarang Exp $

EAPI="4"

inherit git-2

DESCRIPTION="Small footprint implementation of Tcl programming language"
HOMEPAGE="http://jim.tcl.tk"
EGIT_REPO_URI="http://repo.or.cz/r/jimtcl.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc static-libs"
DEPEND="doc? ( app-text/asciidoc )
	app-arch/unzip"

src_configure() {
	! use static-libs && myconf=--with-jim-shared
	econf ${myconf}
}

src_compile() {
	emake all
	use doc && emake docs
}

src_install() {
	dobin jimsh
	use static-libs && {
		dolib.a libjim.a
	} || {
		dolib.so libjim.so
	}
	insinto /usr/include
	doins jim.h jimautoconf.h jim-subcmd.h jim-signal.h
	doins jim-win32compat.h jim-eventloop.h jim-config.h
	dodoc AUTHORS README TODO
	use doc && dohtml Tcl.html
}
