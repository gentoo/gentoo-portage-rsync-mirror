# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cfv/cfv-1.18.3.ebuild,v 1.5 2012/12/02 22:17:29 swegener Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Utility to test and create .sfv, .csv, .crc and md5sum files"
HOMEPAGE="http://cfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/cfv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="bittorrent"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

DEPEND=""
RDEPEND="dev-python/python-fchksum
	bittorrent? (
		|| (
			net-p2p/bittorrent
			net-p2p/bittornado
		)
	)"

src_compile() {
	true
}

src_install() {
	dobin cfv || die "dobin failed"
	doman cfv.1 || die "doman failed"
	dodoc README Changelog || die "dodoc failed"
	python_convert_shebangs -r 2 "${ED}"
}
