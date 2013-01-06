# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splash-themes-gentoo/splash-themes-gentoo-20090926.ebuild,v 1.1 2009/09/26 15:21:18 spock Exp $

EAPI="2"

DESCRIPTION="A collection of Gentoo themes for splashutils."
HOMEPAGE="http://dev.gentoo.org/~spock/"
SRC_URI="mirror://gentoo/fbsplash-theme-emergence-r2.tar.bz2
	 mirror://gentoo/fbsplash-theme-gentoo-r2.tar.bz2
	 mirror://gentoo/fbsplash-theme-emerge-world-1.0.tar.bz2
	 http://fbsplash.berlios.de/themes/repo/natural_gentoo-8.0-r1.tar.bz2"
IUSE=""
LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND=">=media-gfx/splashutils-1.1.9.5[png]"
DEPEND="${RDEPEND}"
RESTRICT="binchecks strip"

src_install() {
	dodir /etc/splash/{emergence,gentoo,natural_gentoo,emerge-world}
	cp -pR "${WORKDIR}"/{emergence,gentoo,natural_gentoo,emerge-world} "${D}/etc/splash"
}

pkg_postinst() {
	elog "The upstream tarball for the 'Natural Gentoo' theme also contains a GRUB"
	elog "splash image which is not installed by this ebuild.  See:"
	elog "  http://www.kde-look.org/content/show.php?content=49074"
	elog "if you are interested in this."
}
