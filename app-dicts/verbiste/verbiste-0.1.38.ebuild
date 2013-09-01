# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/verbiste/verbiste-0.1.38.ebuild,v 1.1 2013/09/01 10:57:39 eva Exp $

EAPI="5"

inherit eutils gnome2-utils fdo-mime

DESCRIPTION="French conjugation system"
HOMEPAGE="http://sarrazip.com/dev/verbiste.html"
SRC_URI="http://sarrazip.com/dev/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="gnome gtk"

RDEPEND="
	>=dev-libs/libxml2-2.4.0:2
	gtk? ( >=x11-libs/gtk+-2.6:2 )
	gnome? (
		gnome-base/gnome-panel[bonobo]
		>=gnome-base/libgnomeui-2.0 )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	econf \
		--with-console-app \
		$(use_with gtk gtk-app) \
		$(use_with gnome gnome-app) \
		$(use_with gnome gnome-applet)
}

src_install() {
	default
	prune_libtool_files
	dodoc HACKING LISEZMOI
	# file is only installed with USE=gnome
	if use gtk && ! use gnome ; then
		sed -e 's/Exec=.*/Exec=verbiste-gtk/' \
			-i src/gnome/verbiste.desktop || die
		insinto usr/share/applications
		doins src/gnome/verbiste.desktop
	fi
}

pkg_preinst() {
	if use gtk || use gnome ; then
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	if use gtk || use gnome ; then
		fdo-mime_desktop_database_update
		fdo-mime_mime_database_update
		gnome2_icon_cache_update
	fi
}

pkg_postrm() {
	if use gtk || use gnome ; then
		fdo-mime_desktop_database_update
		fdo-mime_mime_database_update
		gnome2_icon_cache_update
	fi
}
