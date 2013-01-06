# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/truevision/truevision-0.5.5.2.ebuild,v 1.11 2011/03/29 05:44:26 radhermit Exp $

EAPI=2

inherit eutils gnome2 versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"
EM_V="0.5.4"
DESCRIPTION="Gnome frontend to Povray"
HOMEPAGE="http://truevision.sourceforge.net"
SRC_URI="mirror://sourceforge/truevision/${MY_P}.tar.bz2
	mirror://sourceforge/truevision/${PN}-extramat-${EM_V}.tar.bz2
	mirror://gentoo/${P}-gcc4.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc"

DEPEND=">=x11-libs/gtk+-2.8.8:2
	>=x11-libs/gtkglext-1.0.6-r3
	gnome-base/libgnome
	>=media-gfx/povray-3.6.1
	sys-libs/zlib
	virtual/opengl
	>=gnome-base/libgnomeui-2.12.0"
RDEPEND="${DEPEND}"

DOCS="AUTHORS README ChangeLog TODO"
USE_DESTDIR="1"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_prepare() {
	# Patch for editing gnome-vfs-mime-magic and do update-mime below
	# bug 84530
	epatch "${FILESDIR}"/${P}-makefile-mime-magic.patch
	# bug 148763 - won't compile with gcc4
	epatch "${DISTDIR}"/${P}-gcc4.diff.bz2
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	gnome2_src_install
	# extra materials
	cd "${WORKDIR}"/${PN}-extramat-${EM_V}
	cp -R materials "${D}"/usr/share/truevision/materials/

	# causes segfault related to pygtk, needs investigation
	rm "${D}"/usr/share/truevision/python/plug-ins/starfield.py

	# duplicated, unnecessary documentation
	rm -rf "${D}"/usr/share/doc/${PN}

	# fix desktop entry
	echo "NoDisplay=true" >> "${D}"/usr/share/applications/truevision.desktop
	make_desktop_entry truevision "Truevision" /usr/share/pixmaps/truevision/gnome-truevision.png "Graphics;3DGraphics;RasterGraphics;"
}

pkg_postinst() {
	update-mime-database /usr/share/mime
}
