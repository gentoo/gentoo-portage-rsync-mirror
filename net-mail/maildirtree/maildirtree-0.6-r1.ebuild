# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildirtree/maildirtree-0.6-r1.ebuild,v 1.3 2011/12/03 11:03:57 hwoarang Exp $

EAPI=4

inherit eutils

DESCRIPTION="A utility that prints trees of Courier-style Maildirs."
HOMEPAGE="http://triplehelix.org/~joshk/maildirtree"
SRC_URI="http://triplehelix.org/~joshk/maildirtree/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/maildirtree-0.6-ldflags.patch
}

src_install() {
	make DESTDIR="${D}" install
	dodoc ChangeLog INSTALL README TODO
}
