# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/viewglob/viewglob-2.0.4.ebuild,v 1.9 2012/05/05 04:53:54 jdhore Exp $

EAPI=1

inherit eutils

DESCRIPTION="Graphical display of directories and globs referenced at the shell prompt"
HOMEPAGE="http://viewglob.sourceforge.net/"
SRC_URI="mirror://sourceforge/viewglob/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="
	dev-libs/glib
	x11-libs/gtk+:2
	|| ( app-shells/bash app-shells/zsh )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO || die
}

pkg_postinst() {
	echo
	einfo "/usr/bin/viewglob is a wrapper for vgd and vgseer (client and"
	einfo "daemon, respectively). Generally speaking, this is what you want to"
	einfo "execute from your shell."
	einfo " "
	einfo "Should you prefer to start viewglob with each shell session, try"
	einfo "something like this:"
	einfo " "
	einfo '  if [[ ! $VG_VIEWGLOB_ACTIVE && $DISPLAY ]] ; then'
	einfo '      exec viewglob'
	einfo '  fi'
	einfo " "
	einfo "Have a look at http://viewglob.sourceforge.net/faq.html for a"
	einfo "few more viewglob tricks."
	ewarn " "
	ewarn "There are some known bugs in viewglob with screen. Exercise some"
	ewarn "caution and take results with a pinch of salt if you try the two"
	ewarn "together."
	echo
}
