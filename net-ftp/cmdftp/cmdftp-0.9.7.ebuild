# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/cmdftp/cmdftp-0.9.7.ebuild,v 1.4 2014/02/24 14:16:34 nimiux Exp $

DESCRIPTION="Light weight, yet robust command line FTP client with shell-like
functions."
HOMEPAGE="http://savannah.nongnu.org/projects/cmdftp/"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	econf --enable-largefile || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README AUTHORS
}
