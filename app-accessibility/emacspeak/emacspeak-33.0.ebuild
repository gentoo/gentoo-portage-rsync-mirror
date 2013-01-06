# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak/emacspeak-33.0.ebuild,v 1.2 2010/12/03 18:35:56 williamh Exp $

EAPI="2"

inherit eutils

DESCRIPTION="the emacspeak audio desktop"
HOMEPAGE="http://emacspeak.sourceforge.net/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+espeak"

DEPEND=">=virtual/emacs-22
	espeak? ( app-accessibility/espeak )"

RDEPEND="${DEPEND}
	>=dev-tcltk/tclx-8.4"

src_prepare() {
	epatch "${FILESDIR}"/${P}-greader-garbage.patch
	epatch "${FILESDIR}"/${P}-respect-ldflags.patch
}

src_configure() {
	make config || die
}

src_compile() {
	make emacspeak || die
	if use espeak; then
		cd servers/linux-espeak
		make TCL_VERSION=8.5 || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	if use espeak; then
		cd servers/linux-espeak
		make DESTDIR="${D}" install || die "espeak server instalation failed"
	fi
	dodoc README etc/NEWS* etc/FAQ etc/COPYRIGHT
	dohtml -r install-guide user-guide
}
