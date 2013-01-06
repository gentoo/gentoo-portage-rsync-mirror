# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/xar/xar-1.5.2.ebuild,v 1.5 2010/01/01 19:45:42 fauli Exp $

EAPI=1

inherit autotools eutils

DESCRIPTION="an easily extensible archive format"
HOMEPAGE="http://code.google.com/p/xar"
SRC_URI="http://xar.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="acl +bzip2"

DEPEND="dev-libs/openssl
	dev-libs/libxml2
	sys-libs/zlib
	acl? ( sys-apps/acl )
	bzip2? ( app-arch/bzip2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-automagic_acl_and_bzip2.patch
	eautoconf
}

src_compile() {
	econf $(use_enable acl) $(use_enable bzip2)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc TODO
}
