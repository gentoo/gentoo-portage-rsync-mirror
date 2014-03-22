# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grabcartoons/grabcartoons-2.4.ebuild,v 1.3 2014/03/22 18:41:10 kensington Exp $

EAPI=5

DESCRIPTION="Comic-summarizing utility"
HOMEPAGE="http://grabcartoons.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/perl
	virtual/perl-Getopt-Long"

# Opens a web page, which is unacceptable during an emerge.
RESTRICT="test"

src_install() {
	emake PREFIX="${D}"/usr install
	dodoc ChangeLog README
}
