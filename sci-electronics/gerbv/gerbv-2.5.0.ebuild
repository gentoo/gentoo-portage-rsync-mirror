# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gerbv/gerbv-2.5.0.ebuild,v 1.3 2012/05/04 07:10:19 jdhore Exp $

EAPI="4"

inherit fdo-mime

DESCRIPTION="A RS-274X (Gerber) and NC drill (Excellon) file viewer"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gerbv.sourceforge.net/"

IUSE="unit-mm doc examples"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
RESTRICT="test"

RDEPEND="
	x11-libs/gtk+:2
	>=x11-libs/cairo-1.2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_enable unit-mm) \
		--disable-update-desktop-database
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS BUGS ChangeLog CONTRIBUTORS HACKING NEWS README* TODO

	rm doc/Doxyfile.nopreprocessing
	if use doc; then
		find doc -name "Makefile*" -exec rm -f '{}' \;
		dodoc -r doc/*
	fi

	if use examples; then
		find example -name "Makefile*" -exec rm -f '{}' \;
		dodoc -r example/*
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
