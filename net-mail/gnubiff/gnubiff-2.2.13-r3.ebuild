# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gnubiff/gnubiff-2.2.13-r3.ebuild,v 1.3 2012/05/03 04:18:37 jdhore Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A mail notification program"
HOMEPAGE="http://gnubiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fam nls password"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=gnome-base/libglade-2.3
	dev-libs/popt
	password? ( dev-libs/openssl:0 )
	fam? ( virtual/fam )
	x11-proto/xproto"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-fix-nls.patch \
		"${FILESDIR}"/${P}-gold.patch

	eautoreconf
}

src_configure() {
	# note: --disable-gnome is to avoid deprecated gnome-panel-2.x
	econf \
		$(use_enable debug) \
		--disable-gnome \
		$(use_enable nls) \
		$(use_enable fam) \
		$(use_with password) \
		$(use_with password password-string ${RANDOM}${RANDOM}${RANDOM}${RANDOM})
}
