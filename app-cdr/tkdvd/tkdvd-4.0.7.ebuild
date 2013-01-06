# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/tkdvd/tkdvd-4.0.7.ebuild,v 1.4 2012/09/05 08:36:57 jlec Exp $

inherit eutils

DESCRIPTION="A Tcl/Tk GUI for writing DVDs and CDs"
HOMEPAGE="http://regis.damongeot.free.fr/tkdvd/"
SRC_URI="http://regis.damongeot.free.fr/tkdvd/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="virtual/cdrtools
	 app-cdr/dvd+rw-tools
	 dev-lang/tcl
	 dev-lang/tk"

S=${WORKDIR}/tkdvd

src_compile() {
	einfo "Nothing to compile!"
}

src_install() {
	insinto /usr/share/${PF}/src
	doins src/*

	exeinto /usr/share/${PF}
	doexe TkDVD.sh

	dodir /usr/bin

	cat <<- EOF >"${D}"/usr/bin/tkdvd
	#!/bin/sh
	cd /usr/share/${PF}
	./TkDVD.sh
	EOF

	fperms 755 /usr/bin/tkdvd

	dodoc ChangeLog FAQ INSTALL README TODO doc/config_file

	doicon icons/*.png
}
