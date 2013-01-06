# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xautolock/xautolock-2.2.ebuild,v 1.9 2012/12/16 15:27:38 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="An automatic X screen-locker/screen-saver."
SRC_URI="http://www.ibiblio.org/pub/Linux/X11/screensavers/${P}.tgz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/X11/screensavers/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="
	|| (
		x11-misc/alock
		x11-misc/i3lock
		x11-misc/slimlock
		x11-misc/slock
		x11-misc/xlockmore
		x11-misc/xtrlock
	)
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
	x11-misc/imake
	app-text/rman
	x11-proto/scrnsaverproto"

src_compile() {
	xmkmf || die
	emake EXTRA_LDOPTIONS="${LDFLAGS}" CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin xautolock || die
	newman xautolock.man xautolock.1
	dodoc Changelog Readme Todo || die
}
