# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/slrn/slrn-1.0.0_pre18.ebuild,v 1.4 2011/10/10 18:36:54 grobian Exp $

EAPI=4
inherit eutils

MY_P="${PN}_${PV/_/~}"

DESCRIPTION="A s-lang based newsreader"
HOMEPAGE="http://slrn.sourceforge.net/"
SRC_URI="mirror://debian/pool/main/s/${PN}/${MY_P}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="canlock nls ssl uudeview"

RDEPEND="virtual/mta
	app-arch/sharutils
	>=sys-libs/slang-2.1.3
	canlock? ( net-libs/canlock )
	ssl? ( dev-libs/openssl )
	uudeview? ( dev-libs/uulib )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch
}

src_configure() {
	econf \
		--with-docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--with-slrnpull \
		$(use_with canlock) \
		$(use_with uudeview uu) \
		$(use_enable nls) \
		$(use_with ssl)
}
