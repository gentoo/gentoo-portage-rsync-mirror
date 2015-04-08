# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/carbon-c-relay/carbon-c-relay-0.37.ebuild,v 1.1 2014/12/22 15:15:40 grobian Exp $

EAPI=5

DESCRIPTION="Enhanced C version of Carbon relay, aggregator and rewriter"
HOMEPAGE="https://github.com/grobian/carbon-c-relay"
SRC_URI="https://github.com/grobian/carbon-c-relay/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

src_install() {
	newbin relay ${PN}
	dodoc README.md
}
