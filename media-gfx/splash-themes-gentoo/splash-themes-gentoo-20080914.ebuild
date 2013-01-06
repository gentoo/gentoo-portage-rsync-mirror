# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splash-themes-gentoo/splash-themes-gentoo-20080914.ebuild,v 1.4 2009/03/08 18:06:04 maekke Exp $

DESCRIPTION="A collection of Gentoo themes for splashutils."
HOMEPAGE="http://dev.gentoo.org/~spock/"
SRC_URI="mirror://gentoo/fbsplash-theme-emergence-r2.tar.bz2
	 mirror://gentoo/fbsplash-theme-gentoo-r2.tar.bz2
	 mirror://gentoo/fbsplash-theme-natural_gentoo-7.1.tar.bz2"
IUSE=""
LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
DEPEND=">=media-gfx/splashutils-1.1.9.5"
RESTRICT="binchecks strip"

src_install() {
	dodir /etc/splash/{emergence,gentoo,natural_gentoo}
	cp -pR "${WORKDIR}"/{emergence,gentoo,natural_gentoo} "${D}/etc/splash"
}

pkg_postinst() {
	elog "The upstream tarball for the 'Natural Gentoo' theme also contains a GRUB"
	elog "splash image which is not installed by this ebuild.  See:"
	elog "  http://www.kde-look.org/content/show.php?content=49074"
	elog "if you are interested in this."
}
