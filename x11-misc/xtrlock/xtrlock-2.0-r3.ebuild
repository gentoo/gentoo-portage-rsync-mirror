# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xtrlock/xtrlock-2.0-r3.ebuild,v 1.4 2012/03/05 10:33:30 ago Exp $

inherit toolchain-funcs

#Note: there's no difference vs 2.0-12
MY_P=${P/-/_}-14

DESCRIPTION="A simplistic screen locking program for X"
SRC_URI="mirror://debian/pool/main/x/xtrlock/${MY_P}.tar.gz"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/x/xtrlock/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-misc/imake"

src_compile() {
	xmkmf || die
	emake CDEBUGFLAGS="${CFLAGS} -DSHADOW_PWD" CC="$(tc-getCC)" \
		EXTRA_LDOPTIONS="${LDFLAGS}" xtrlock || die
}

src_install() {
	dobin xtrlock || die
	chmod u+s "${D}"/usr/bin/xtrlock
	newman xtrlock.man xtrlock.1 || die
}
