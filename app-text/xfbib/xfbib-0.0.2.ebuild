# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xfbib/xfbib-0.0.2.ebuild,v 1.4 2012/11/15 19:45:56 nativemad Exp $

EAPI=1

inherit gnome2-utils

DESCRIPTION="a lightweight BibTeX editor"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfbib"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/libxfce4util-4.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_preinst() {
	gnome2_icon_savelist
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
