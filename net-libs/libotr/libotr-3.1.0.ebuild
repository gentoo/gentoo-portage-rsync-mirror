# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libotr/libotr-3.1.0.ebuild,v 1.9 2009/08/22 15:52:50 halcy0n Exp $

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-libs/libgpg-error
	>=dev-libs/libgcrypt-1.2.0"

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodoc ChangeLog README
}
