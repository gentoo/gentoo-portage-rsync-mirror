# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alltray/alltray-0.7.4.ebuild,v 1.2 2012/05/05 04:53:51 jdhore Exp $

EAPI=4
inherit eutils

MY_P=${P}dev

DESCRIPTION="Dock any application into the system tray/notification area"
HOMEPAGE="http://alltray.trausch.us/"
SRC_URI="http://code.launchpad.net/${PN}/trunk/${PV}dev/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/libwnck:1
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog README )

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-include-fixes.patch

	# Drop DEPRECATED flags, bug #391101
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED::' src/Makefile.{am,in} || die
}
