# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdcollect/rrdcollect-0.2.9.ebuild,v 1.2 2011/06/09 17:46:29 jer Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Read system statistical data and feed it to RRDtool"
HOMEPAGE="http://rrdcollect.sourceforge.net/"
SRC_URI="mirror://sourceforge/rrdcollect/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="exec librrd pcre"

DEPEND="
	librrd? ( net-analyzer/rrdtool )
	pcre? ( dev-libs/libpcre )
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-include.patch
}

src_configure() {
	econf \
		$(use_with pcre libpcre) \
		$(use_with librrd) \
		$(use_enable exec) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS TODO || die
	docinto examples
	dodoc doc/examples/* || die
}
