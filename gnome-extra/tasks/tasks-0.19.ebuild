# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/tasks/tasks-0.19.ebuild,v 1.3 2012/05/05 06:25:15 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="A small, lightweight to-do list for Gnome"
HOMEPAGE="http://pimlico-project.org/tasks.html"
SRC_URI="http://pimlico-project.org/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-extra/evolution-data-server-1.8
	>=x11-libs/gtk+-2.16:2
	>=dev-libs/glib-2.14:2
	>=dev-libs/libunique-1:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.33
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} --with-unique --enable-gtk"
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.16-asneeded.patch"
	eautoreconf
}
