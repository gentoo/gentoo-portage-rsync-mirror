# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pcmanfm/pcmanfm-1.0.ebuild,v 1.1 2012/08/12 19:57:34 hwoarang Exp $

EAPI="2"
inherit eutils fdo-mime

MY_PV="${PV/_/}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.16:2
	>=lxde-base/menu-cache-0.3.2
	x11-misc/shared-mime-info
	>=x11-libs/libfm-1.0
	virtual/eject"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	sys-devel/gettext"

S="${WORKDIR}"/${MY_P}

src_configure() {
	strip-linguas -i "${S}/po"
	econf --sysconfdir=/etc $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	elog 'PCmanFM can optionally support the menu://applications/ location.'
	elog 'You should install lxde-base/lxmenu-data for that functionality.'
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
