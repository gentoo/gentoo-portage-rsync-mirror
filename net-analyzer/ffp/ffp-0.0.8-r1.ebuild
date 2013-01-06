# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ffp/ffp-0.0.8-r1.ebuild,v 1.1 2012/12/05 16:21:26 jer Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="a tool to do fuzzy fingerprinting for man-in-the-middle attacks"
HOMEPAGE="http://www.thc.org/thc-ffp/"
SRC_URI="http://www.thc.org/releases/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

DOCS=( README TODO doc/ffp.pdf )

src_prepare() {
	tc-export CC
}
src_install() {
	default
	dohtml doc/ffp.html
}
