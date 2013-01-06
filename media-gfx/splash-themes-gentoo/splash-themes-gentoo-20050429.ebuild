# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splash-themes-gentoo/splash-themes-gentoo-20050429.ebuild,v 1.6 2007/02/17 11:39:43 spock Exp $

DESCRIPTION="A collection of Gentoo themes for splashutils."
HOMEPAGE="http://dev.gentoo.org/~spock/"
SRC_URI="mirror://gentoo/fbsplash-theme-emergence-r2.tar.bz2
	 mirror://gentoo/fbsplash-theme-gentoo-r2.tar.bz2"
IUSE=""
LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
DEPEND=">=media-gfx/splashutils-1.1.9.5"
RESTRICT="binchecks strip"

src_install() {
	dodir /etc/splash/{emergence,gentoo}
	cp -pR ${WORKDIR}/{emergence,gentoo} ${D}/etc/splash
}
