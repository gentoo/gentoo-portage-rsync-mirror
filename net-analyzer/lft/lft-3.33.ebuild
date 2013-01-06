# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-3.33.ebuild,v 1.6 2012/02/01 17:37:40 jer Exp $

EAPI="4"

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://oppleman.com/lft/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="VOSTROM"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

DOCS=( CHANGELOG README TODO )

src_prepare() {
	sed -i Makefile.in -e '/[Ss]trip/d' || die
}
