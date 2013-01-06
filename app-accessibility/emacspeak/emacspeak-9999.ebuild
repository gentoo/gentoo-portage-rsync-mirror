# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak/emacspeak-9999.ebuild,v 1.5 2010/12/03 18:35:56 williamh Exp $

EAPI="2"

inherit eutils

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"
	inherit subversion
	KEYWORDS=""
else
	SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"
	KEYWORDS="~amd64 ~ppc ~x86"
fi

DESCRIPTION="the emacspeak audio desktop"
HOMEPAGE="http://emacspeak.sourceforge.net/"
LICENSE="BSD GPL-2"
SLOT="0"
IUSE="+espeak"

DEPEND=">=virtual/emacs-22
	espeak? ( app-accessibility/espeak )"

RDEPEND="${DEPEND}
	>=dev-tcltk/tclx-8.4"

src_prepare() {
	# Allow user patches to be applied without modifying the ebuild
	epatch_user
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
	dodoc README etc/NEWS* etc/FAQ etc/COPYRIGHT
	dohtml -r install-guide user-guide
	if use espeak; then
		cd servers/linux-espeak
		make DESTDIR="${D}" install
	fi
}
