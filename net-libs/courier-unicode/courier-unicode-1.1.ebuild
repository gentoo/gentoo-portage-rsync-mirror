# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/courier-unicode/courier-unicode-1.1.ebuild,v 1.4 2015/03/03 22:21:11 maekke Exp $

EAPI=5
inherit eutils

DESCRIPTION="Unicode library used by the courier mail server"
HOMEPAGE="http://www.courier-mta.org/"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

src_install() {
	default
	prune_libtool_files
	dodoc AUTHORS ChangeLog README
}
