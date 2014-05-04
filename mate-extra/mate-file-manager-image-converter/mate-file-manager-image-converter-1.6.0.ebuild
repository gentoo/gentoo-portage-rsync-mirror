# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-file-manager-image-converter/mate-file-manager-image-converter-1.6.0.ebuild,v 1.2 2014/05/04 14:54:30 ago Exp $

EAPI="5"

inherit autotools gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Adds a 'Resize Images' item to the context menu for all images"
HOMEPAGE="http://www.mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=dev-libs/glib-2.28:2
	>=mate-base/mate-file-manager-1.6:0
	>=x11-libs/gtk+-2.12
	virtual/libintl:0
	|| (
		media-gfx/imagemagick:0=
		media-gfx/graphicsmagick:0[imagemagick]
	)"

DEPEND="${RDEPEND}
	dev-util/intltool:*
	sys-devel/gettext:*
	virtual/pkgconfig:*
"

src_prepare() {
	# Tarball has no proper build system, should be fixed on next release.
	eautoreconf

	gnome2_src_prepare
}

DOCS="AUTHORS ChangeLog NEWS README"
