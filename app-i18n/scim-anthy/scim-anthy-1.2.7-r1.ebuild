# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-anthy/scim-anthy-1.2.7-r1.ebuild,v 1.1 2013/09/16 10:42:49 heroxbd Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="Japanese input method Anthy IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMAnthy"
SRC_URI="mirror://sourceforge.jp/scim-imengine/37309/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="+gtk3 nls kasumi"

DEPEND=">=app-i18n/scim-1.2[gtk3=]
	>=app-i18n/anthy-5900
	nls? ( virtual/libintl )
	gtk3? ( x11-libs/gtk+:3 )"
RDEPEND="${DEPEND}
	kasumi? ( app-dicts/kasumi )"
DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.7-no-rpath.patch

	use gtk3 && epatch "${FILESDIR}"/${PN}-1.2.7-gtk3.patch

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-static \
		--disable-dependency-tracking
}

src_install() {
	default
	dodoc AUTHORS ChangeLog NEWS README
}
