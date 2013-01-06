# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/notecase/notecase-1.9.8.ebuild,v 1.5 2012/05/04 03:33:17 jdhore Exp $

EAPI="1"

inherit eutils fdo-mime

DESCRIPTION="Hierarchical note manager written using GTK+ and C++"
HOMEPAGE="http://notecase.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}_src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnome nls"

RDEPEND=">=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# test doesn't work
RESTRICT="test"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Respect CFLAGS and don't use --as-needed by default
	epatch "${FILESDIR}/notecase-1.7.2-CFLAGS.patch"
	epatch "${FILESDIR}"/${P}-gcc44.patch
	epatch "${FILESDIR}"/${P}-gtksourceview.patch

	if ! use gnome; then
		# Comment variable in the Makefile if we don't have gnome
		sed -i -e 's/HAVE_GNOME_VFS=1/#HAVE_GNOME_VFS=1/g' \
				-e 's/AUTODETECT_GNOME_VFS=1/#AUTODETECT_GNOME_VFS=1/g' \
			 Makefile || die "gnome sed failed"
	fi

	! use nls && {
		sed -i -e 's/notecase$(EXE) poinstall/notecase$(EXE)/g' \
			Makefile || die "nls sed failed"
		}
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc readme.txt
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
