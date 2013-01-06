# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnucap/gnucap-0.35.ebuild,v 1.9 2011/05/21 16:26:31 armin76 Exp $

inherit eutils

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://www.gnucap.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.gnucap.org/"

IUSE="doc examples"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

DEPEND="doc? ( virtual/latex-base )"

src_unpack() {
	unpack ${A} || die "Failed to unpack!"
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc43.patch

	# No need to install COPYING and INSTALL
	sed -i \
		-e 's: COPYING INSTALL::' \
		-e 's:COPYING history INSTALL:history:' \
		doc/Makefile.in || die "sed failed"

	if ! use doc ; then
		sed -i \
			-e 's:SUBDIRS = doc examples man:SUBDIRS = doc examples:' \
			Makefile.in || die "sed failed"
	fi

	if ! use examples ; then
		sed -i \
			-e 's:SUBDIRS = doc examples:SUBDIRS = doc:' \
			Makefile.in || die "sed failed"
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "Installation failed"
}
