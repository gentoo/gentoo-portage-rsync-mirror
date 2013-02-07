# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/cwdaemon/cwdaemon-0.9.2.ebuild,v 1.8 2013/02/07 08:57:38 tomjbe Exp $

DESCRIPTION="A morse daemon for the parallel or serial port"
HOMEPAGE="http://www.qsl.net/pg4i/linux/cwdaemon.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
}
