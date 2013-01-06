# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/re2c/re2c-0.13.2.ebuild,v 1.3 2009/09/23 17:47:41 patrick Exp $

inherit eutils

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.sourceforge.net/"
MY_PV="${PV/_/.}"
MY_P="${PN}-${MY_PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A} || die
	# Fix permissions
	chmod -R u+rw "${S}"
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-0.9.11-gcc41.patch
}

src_compile() {
	econf || die
	emake -e || die
}

src_install() {
	dobin re2c || die "dobin failed"
	doman re2c.1 || die "doman failed"
	dodoc README CHANGELOG doc/* && \
	docinto examples && \
	dodoc examples/*.c examples/*.re || die "docs failed"
}
