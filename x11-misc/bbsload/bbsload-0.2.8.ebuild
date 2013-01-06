# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbsload/bbsload-0.2.8.ebuild,v 1.19 2013/01/02 21:11:01 ranger Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="blackbox load monitor"
HOMEPAGE="http://sourceforge.net/projects/bbtools/"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-fonts/font-adobe-100dpi"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README AUTHORS BUGS ChangeLog NEWS TODO data/README.bbsload
}
