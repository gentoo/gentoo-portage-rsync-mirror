# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glosung/glosung-2.1.3.ebuild,v 1.6 2012/05/04 03:33:17 jdhore Exp $

EAPI="1"

DESCRIPTION="watch word program for the GNOME2 desktop (watch word (german): losung)"
HOMEPAGE="http://www.godehardt.org/losung.html"
SRC_URI="http://www.godehardt.org/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="amd64 x86"

RDEPEND=">=gnome-base/gconf-2.0:2
	>=x11-libs/gtk+-2.4:2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.93
	virtual/pkgconfig
	>=dev-util/intltool-0.22
	>=sys-devel/gettext-0.10"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#remove -Werror for updated glibc and gcc
	sed -i -e 's:-Werror ::g' SConstruct
}

src_compile() {
	scons ${MAKEOPTS} || die
}

src_install() {
	scons install DESTDIR="${D}" || die
}
