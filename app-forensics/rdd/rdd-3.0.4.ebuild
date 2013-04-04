# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/rdd/rdd-3.0.4.ebuild,v 1.1 2013/04/04 08:11:50 patrick Exp $

EAPI="5"

inherit autotools

# no worky
RESTRICT="test"

DESCRIPTION="Rdd is a forensic copy program"
HOMEPAGE="http://www.sf.net/projects/rdd"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
IUSE="debug"
LICENSE="BSD"
SLOT="0"

DEPEND="app-forensics/libewf
	x11-libs/gtk+:2
	gnome-base/libglade:2.0"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/AM_PATH_GTK_2_0//' configure.ac || die
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug tracing)
}
src_compile() {
	emake -j1
}

src_install() {
        # emake install has a sandbox violation in src/Makefile
        dobin src/rdd-copy
        dobin src/rdd-verify
        dobin src/rddi.py
        doman src/*.1
        dohtml doxygen-doc/html/*
        dosym rdd-copy /usr/bin/rdd
        dosym rddi.py /usr/bin/rddi
}

