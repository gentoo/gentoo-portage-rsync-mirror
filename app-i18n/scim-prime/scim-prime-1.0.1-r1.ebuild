# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-prime/scim-prime-1.0.1-r1.ebuild,v 1.6 2013/06/18 04:07:38 mr_bones_ Exp $

EAPI=4

inherit eutils autotools-utils

DESCRIPTION="Japanese input method PRIME IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMPRIME"
SRC_URI="mirror://sourceforge.jp/scim-imengine/29156/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="static-libs"

RDEPEND=">=app-i18n/scim-1.0
	>=app-i18n/prime-1.0.0
	dev-libs/atk
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
DOCS=( AUTHORS ChangeLog NEWS README TODO )

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
