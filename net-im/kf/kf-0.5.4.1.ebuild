# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kf/kf-0.5.4.1.ebuild,v 1.4 2011/10/27 06:40:08 tetromino Exp $

EAPI=2
inherit eutils

DESCRIPTION="kf is a simple Jabber messenger."
HOMEPAGE="http://kf.jabberstudio.org/"
SRC_URI="http://files.jabberstudio.org/kf/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="spell debug"
DEPEND="x11-libs/gtk+:2
	>=net-libs/loudmouth-0.16
	>=gnome-base/libglade-2
	spell? ( >=app-text/gtkspell-2.0.4:2 )"

KEYWORDS="~x86 ~ppc ~sparc"

src_prepare() {
	# wrong use of typedef struct _KfJispManager
	epatch "${FILESDIR}"/${P}-typedef_KfJispManager.patch
}

src_configure() {
	econf $(use_enable spell gtkspell) \
		  $(use_enable debug) || die 'econf failed'
}

src_compile() {
	emake || die 'emake failed'
}

src_install() {
	make install DESTDIR="${D}" || die 'make install failed'
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
