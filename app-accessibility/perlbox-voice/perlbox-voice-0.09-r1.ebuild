# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/perlbox-voice/perlbox-voice-0.09-r1.ebuild,v 1.6 2013/06/07 14:13:13 zlogene Exp $

IUSE=""

DESCRIPTION="A voice enabled application to bring your desktop under your command."

HOMEPAGE="http://perlbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/perlbox/${P}.noarch.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-lang/perl
	dev-perl/perl-tk
	app-accessibility/sphinx2
	app-accessibility/festival
	app-arch/tar
	app-accessibility/mbrola"

DEPEND=""

src_install() {
	tar xvf perlbox-voice.ss -C "${D}"
	dodoc README
}
