# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grabcartoons/grabcartoons-2.4.ebuild,v 1.2 2013/04/09 16:36:17 tomwij Exp $

EAPI="5"

DESCRIPTION="Comic-summarizing utility"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/perl
	virtual/perl-Getopt-Long"

src_install() {
	emake PREFIX="${D}"/usr install
	dodoc ChangeLog README
}

# Opens a web page, which is unacceptable during an emerge.
src_test() {
	:
}
