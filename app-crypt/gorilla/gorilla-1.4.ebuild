# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gorilla/gorilla-1.4.ebuild,v 1.5 2014/08/10 02:27:01 patrick Exp $

inherit eutils

DESCRIPTION="Password Safe clone for Linux. Stores passwords in secure way with
GUI interface"
HOMEPAGE="http://www.fpx.de/fp/Software/Gorilla/"
SRC_URI="http://www.fpx.de/fp/Software/Gorilla/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4.19
	>=dev-lang/tk-8.4.19
	dev-tcltk/iwidgets
	dev-tcltk/bwidget"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-script-destdir.patch
}

src_compile() {
	./configure || die "econf failed"
}

src_install() {
	PREFIX="/opt/${P}"

	dodir ${PREFIX}
	insinto ${PREFIX}
	doins gorilla.tcl isaac.tcl

	dodir ${PREFIX}/twofish
	insinto ${PREFIX}/twofish
	doins twofish/*

	dodir ${PREFIX}/sha1
	insinto ${PREFIX}/sha1
	doins sha1/*

	dodir ${PREFIX}/blowfish
	insinto ${PREFIX}/blowfish
	doins blowfish/*

	dodir ${PREFIX}/pwsafe
	insinto ${PREFIX}/pwsafe
	doins pwsafe/*

	dodir ${PREFIX}/pics
	insinto ${PREFIX}/pics
	doins pics/*

	exeinto /usr/bin
	doexe gorilla
}
