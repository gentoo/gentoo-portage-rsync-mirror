# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/physlock/physlock-0.4.3.ebuild,v 1.1 2012/10/24 03:51:45 radhermit Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="lightweight Linux console locking tool"
HOMEPAGE="https://github.com/muennich/physlock"
SRC_URI="mirror://github/muennich/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
