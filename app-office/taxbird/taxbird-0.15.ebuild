# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/taxbird/taxbird-0.15.ebuild,v 1.4 2011/03/21 21:45:52 nirbheek Exp $

EAPI="2"

inherit eutils fdo-mime

DESCRIPTION="Taxbird provides a GUI to submit tax forms to the german digital tax project ELSTER."
HOMEPAGE="http://www.taxbird.de/"
SRC_URI="http://www.taxbird.de/download/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libgeier-0.11
	>=gnome-extra/gtkhtml-3.8:3.14
	gnome-base/libgnomeui
	sys-devel/gettext
	>=dev-scheme/guile-1.8.0[regex,deprecated]"

src_install() {
	dodoc README* || die "dodoc failed"

	einstall || die "Installation failed!"

	# clean out the installed mime files, those get recreated in the pkg_postinst function
	einfo "Deleting mime files in ${D}/usr/share/mime"
	find "${D}/usr/share/mime/" -type f -maxdepth 1 -delete
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
