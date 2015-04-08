# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/bwidget/bwidget-1.9.7.ebuild,v 1.9 2015/04/02 20:12:09 maekke Exp $

EAPI=5

inherit eutils multilib virtualx

MY_PN=${PN/bw/BW}
MY_P=${MY_PN}-${PV}

DESCRIPTION="High-level widget set for Tcl/Tk"
HOMEPAGE="http://tcllib.sourceforge.net/"
SRC_URI="mirror://sourceforge/tcllib/${P}.zip"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ppc ppc64 sparc x86"
IUSE="doc"

DEPEND="dev-lang/tk"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-test.patch
}

src_test() {
	VIRTUALX_COMMAND=tclsh
	virtualmake tests/entry.test
}

src_install() {
	insinto /usr/$(get_libdir)/${P}
	doins *.tcl
	doins -r images lang

	insinto /usr/share/doc/${PF}/
	doins -r demo
	dodoc ChangeLog README.txt

	use doc && dohtml BWman/*
}
