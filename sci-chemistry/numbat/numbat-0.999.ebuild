# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/numbat/numbat-0.999.ebuild,v 1.2 2013/05/21 10:58:45 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils

MY_PN="Numbat"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="new user-friendly method built for automatic dX-tensor determination"
HOMEPAGE="http://www.nmr.chem.uu.nl/~christophe/numbat.html"
SRC_URI="http://comp-bio.anu.edu.au/private/downloads/Numbat/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

CDEPEND="
	gnome-base/libglade:2.0
	sci-libs/gsl
	x11-libs/gtk+:2"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	sci-chemistry/molmol
	sci-chemistry/pymol"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	sed \
		-e '/COPYING/d' \
		-e "s:doc/numbat:share/doc/${PF}:g" \
		-i Makefile.am src/common.h || die
	autotools-utils_src_prepare
}

src_install() {
	docompress -x /usr/share/doc/${PF}
	autotools-utils_src_install
}
