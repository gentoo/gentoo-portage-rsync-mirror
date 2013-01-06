# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md6sum/md6sum-1.0-r1.ebuild,v 1.3 2012/11/19 22:43:39 tomka Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A C implementation of MD6"
HOMEPAGE="http://groups.csail.mit.edu/cis/md6"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
	epatch "${FILESDIR}/${P}-cflags.patch"
}

src_install() {
	emake DESTDIR="${D}" install
	newdoc README_Reference.txt README
}
