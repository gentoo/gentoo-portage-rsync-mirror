# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-1.0.7.ebuild,v 1.8 2012/05/03 18:33:02 jdhore Exp $

EAPI=1
inherit eutils fdo-mime

IUSE="nls spell gnome"

DESCRIPTION="A GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://www.bennewitz.com/bluefish/stable/source/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
SLOT="0"

RDEPEND="x11-libs/gtk+:2
	dev-libs/libpcre
	spell? ( app-text/aspell )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	gnome? ( gnome-base/libgnomeui )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's/-s -m 755/-m 755/g' src/Makefile.in
}

src_compile() {
	econf --disable-update-databases \
		`use_enable nls` \
		`use_with gnome libgnomeui` || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
