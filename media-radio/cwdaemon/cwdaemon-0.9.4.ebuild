# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/cwdaemon/cwdaemon-0.9.4.ebuild,v 1.5 2012/06/25 18:37:35 tomjbe Exp $

EAPI=4
inherit eutils

DESCRIPTION="A morse daemon for the parallel or serial port"
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/ham/morse"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-radio/unixcw-3.0.2"
DEPEND="$RDEPEND
	virtual/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-unixcw3.patch
}
