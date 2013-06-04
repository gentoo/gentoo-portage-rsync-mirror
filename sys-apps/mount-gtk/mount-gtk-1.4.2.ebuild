# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mount-gtk/mount-gtk-1.4.2.ebuild,v 1.1 2013/06/04 19:22:28 ssuominen Exp $

EAPI=5
inherit autotools flag-o-matic

DESCRIPTION="GTK+ based UDisks2 frontend"
HOMEPAGE="http://mount-gtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.28
	sys-fs/udisks:2
	x11-libs/c++-gtk-utils:0
	x11-libs/libX11
	x11-libs/libnotify:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS BUGS ChangeLog )

src_prepare() {
	sed -i -e 's:AC_CONFIG_HEADER:&S:' configure.ac || die
	eautoreconf
}

src_configure() {
	append-cxxflags -fexceptions -frtti -fsigned-char -fno-check-new -pthread -std=c++11
#	unset CXXFLAGS
	econf --docdir=/usr/share/doc/${PF}
}
