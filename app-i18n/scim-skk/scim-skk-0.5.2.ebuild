# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-skk/scim-skk-0.5.2.ebuild,v 1.6 2012/05/03 19:24:33 jdhore Exp $

DESCRIPTION="Japanese input method SKK IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMSKK"
SRC_URI="mirror://sourceforge.jp/scim-imengine/18121/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

DEPEND="|| ( >=app-i18n/scim-1.2 >=app-i18n/scim-cvs-1.2 )"
RDEPEND="${DEPEND}
	|| ( app-i18n/skk-jisyo virtual/skkserv )
	nls? ( virtual/libintl )"
DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_compile() {
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking \
		--disable-static || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	elog
	elog "To use SCIM, you should use the following in your user startup scripts"
	elog "such as .gnomerc or .xinitrc:"
	elog
	elog "LANG='your_language' scim -d"
	elog "export XMODIFIERS=@im=SCIM"
	elog "export GTK_IM_MODULE=scim"
	elog "export QT_IM_MODULE=scim"
	elog
}
