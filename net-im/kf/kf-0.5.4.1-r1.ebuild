# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kf/kf-0.5.4.1-r1.ebuild,v 1.1 2013/08/18 14:36:27 mrueg Exp $

EAPI=5
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
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 ~x86 ~ppc ~sparc"

src_prepare() {
	# wrong use of typedef struct _KfJispManager
	epatch "${FILESDIR}"/${P}-typedef_KfJispManager.patch
}

src_configure() {
	econf $(use_enable spell gtkspell) \
		  $(use_enable debug)
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
