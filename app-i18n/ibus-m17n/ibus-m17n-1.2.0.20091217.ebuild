# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-m17n/ibus-m17n-1.2.0.20091217.ebuild,v 1.5 2012/05/03 19:24:28 jdhore Exp $

DESCRIPTION="The M17N engine IMEngine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=app-i18n/ibus-1.2
	dev-libs/m17n-lib
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-db/m17n-db
	dev-db/m17n-contrib
	>=sys-devel/gettext-0.16.1"

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
