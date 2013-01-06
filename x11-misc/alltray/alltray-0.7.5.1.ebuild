# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alltray/alltray-0.7.5.1.ebuild,v 1.8 2012/09/08 05:54:22 nirbheek Exp $

EAPI=4
inherit autotools

MY_P=${P}dev

DESCRIPTION="An application which allows any application to be docked into the system notification area"
HOMEPAGE="http://alltray.trausch.us/"
SRC_URI="http://code.launchpad.net/${PN}/trunk/${PV}dev/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libwnck:1"
DEPEND="${RDEPEND}
	dev-lang/vala:0.14
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

src_prepare() {
	sed -i -e 's:-DG.*DISABLE_DEPRECATED::' src/Makefile.{am,in} || die #391101

	sed -i \
		-e '/Encoding/d' \
		-e '/Categories/s:Application;::' \
		-e '/Icon/s:.png::' \
		data/alltray.desktop{,.in} || die

	sed -i -e '/AC_PATH_PROG/s:valac:valac-0.14:g' configure.ac || die

	eautoreconf
}
