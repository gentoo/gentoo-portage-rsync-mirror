# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splash-themes-livecd/splash-themes-livecd-2004.3.ebuild,v 1.6 2008/09/14 11:44:30 spock Exp $

S="${WORKDIR}/livecd-${PV}"
DESCRIPTION="Gentoo theme for gensplash consoles"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${PF}.tar.bz2"

SLOT=${PV}
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="binchecks strip"

DEPEND="media-gfx/splashutils"

src_install() {
	dodir /etc/splash/livecd-${PV}
	cp -r "${S}"/* "${D}"/etc/splash/livecd-${PV}
}
