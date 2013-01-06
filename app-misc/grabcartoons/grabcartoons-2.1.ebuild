# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grabcartoons/grabcartoons-2.1.ebuild,v 1.2 2012/10/29 08:27:51 ago Exp $

EAPI=4

DESCRIPTION="comic-summarizing utility"
HOMEPAGE="http://grabcartoons.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

src_install() {
	emake PREFIX="${D}"/usr install
	dodoc ChangeLog README
}
