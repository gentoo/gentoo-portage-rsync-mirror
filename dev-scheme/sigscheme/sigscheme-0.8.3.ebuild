# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/sigscheme/sigscheme-0.8.3.ebuild,v 1.2 2010/10/06 03:20:55 chiiph Exp $

EAPI="3"

DESCRIPTION="SigScheme is an R5RS Scheme interpreter for embedded use."
HOMEPAGE="http://code.google.com/p/sigscheme/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_configure() {
	econf --enable-hygienic-macro
}
