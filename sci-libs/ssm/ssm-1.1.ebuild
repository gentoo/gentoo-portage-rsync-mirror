# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ssm/ssm-1.1.ebuild,v 1.7 2012/05/21 19:14:47 ranger Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="A macromolecular coordinate superposition library"
HOMEPAGE="https://launchpad.net/ssm"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

DEPEND=">=sci-libs/mmdb-1.23"
RDEPEND="${DEPEND}
	!<sci-libs/ccp4-libs-6.1.3-r10"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-mmdb.patch \
		"${FILESDIR}"/${P}-pc.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
