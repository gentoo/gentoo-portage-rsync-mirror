# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-commander/gnome-commander-1.4.1.ebuild,v 1.2 2014/05/05 10:25:44 hwoarang Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils gnome2 python-single-r1

DESCRIPTION="A full featured, twin-panel file manager for Gnome2"
HOMEPAGE="http://gcmd.github.io/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chm doc exif gsf pdf python taglib"

RDEPEND="app-text/gnome-doc-utils
	>=dev-libs/glib-2.6.0:2
	>=dev-libs/libunique-0.9.3:1
	dev-util/meld
	gnome-base/gnome-keyring
	>=gnome-base/gnome-vfs-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.4.0
	>=x11-libs/gtk+-2.8.0:2
	chm? ( dev-libs/chmlib )
	doc? ( app-text/scrollkeeper
		gnome-extra/yelp )
	exif? ( >=media-gfx/exiv2-0.14 )
	gsf? ( >=gnome-extra/libgsf-1.12.0 )
	pdf? ( >=app-text/poppler-0.18 )
	python? ( >=dev-python/gnome-vfs-python-2.0.0 )
	taglib? ( >=media-libs/taglib-1.4 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

src_configure() {
	G2CONF="$(use_enable doc scrollkeeper)
		$(use_enable python)
		$(use_with chm libchm)
		$(use_with exif exiv2)
		$(use_with gsf libgsf)
		$(use_with taglib)
		$(use_with pdf poppler)"
	gnome2_src_configure
}
