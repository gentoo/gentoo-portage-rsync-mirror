# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgrep/sgrep-1.94a.ebuild,v 1.1 2012/01/21 06:39:05 radhermit Exp $

EAPI=4

DESCRIPTION="Structured grep: tool for searching and indexing text, SGML,XML and HTML files and filtering text streams using structural criteria."
SRC_URI="ftp://ftp.cs.helsinki.fi/pub/Software/Local/Sgrep/${P}.tar.gz"
HOMEPAGE="http://www.cs.helsinki.fi/u/jjaakkol/sgrep.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_prepare() {
	sed -i -e "s:/usr/lib:/etc:g" sgrep.1
}

src_configure() {
	econf --datadir="${EPREFIX}"/etc
}

src_install() {
	dobin sgrep
	doman sgrep.1
	dodoc AUTHORS ChangeLog NEWS README sample.sgreprc
	insinto /etc
	newins sample.sgreprc sgreprc
}
