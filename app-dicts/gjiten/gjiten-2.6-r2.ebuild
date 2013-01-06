# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gjiten/gjiten-2.6-r2.ebuild,v 1.1 2012/10/12 23:55:24 naota Exp $

EAPI=2
inherit autotools eutils gnome2

DESCRIPTION="A Japanese dictionary program for Gnome"
HOMEPAGE="http://gjiten.sourceforge.net/"
SRC_URI="http://gjiten.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RESTRICT="test"

RDEPEND=">=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	app-text/rarian
	dev-util/intltool
	app-text/xmlto
	app-text/docbook-xml-dtd:4.1.2
	virtual/pkgconfig"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${P}-pref.patch
	# bug #124631
	intltoolize --copy --automake --force || die "intltoolize failed"
	AM_OPTS="--foreign" eautoreconf
}

pkg_postinst() {
	elog
	elog "Dictionary files are necessary in order for"
	elog "Gjiten to function."
	elog
	elog "Download dictionary files from:"
	elog "http://ftp.cc.monash.edu.au/pub/nihongo/00INDEX.html#dic_fil"
	elog "You need kanjidic and edict at a minimum.  Dictionary files"
	elog "must be converted to UTF-8 format - check the Gjiten help"
	elog "and README files for details."
	elog
	elog "A shell script is available from "
	elog "the Gjiten homepage(${HOMEPAGE}) to"
	elog "download and convert the dictionary files, but you need"
	elog "to put the files in /usr/share/gjiten after running the script."
	elog

	gnome2_pkg_postinst
}
