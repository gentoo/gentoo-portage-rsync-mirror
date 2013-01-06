# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/ck/ck-8.0-r3.ebuild,v 1.3 2012/02/24 14:10:29 phajdan.jr Exp $

EAPI=4

inherit eutils multilib

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A curses based toolkit for tcl"
HOMEPAGE="http://www.ch-werner.de/ck/"
SRC_URI="http://www.ch-werner.de/ck/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/tk"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed \
		-e "/^LIB_INSTALL_DIR/s:lib$:$(get_libdir):g" \
		-i Makefile.in || die
}

src_configure() {
	econf \
		--with-tcl="${EPREFIX}/usr/$(get_libdir)" \
		--enable-shared
}
