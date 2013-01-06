# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-tools/tpm-tools-1.3.5.ebuild,v 1.4 2011/03/31 22:19:40 flameeyes Exp $

EAPI="2"
inherit autotools

DESCRIPTION="TrouSerS' support tools for the Trusted Platform Modules"
HOMEPAGE="http://trousers.sourceforge.net"
SRC_URI="mirror://sourceforge/trousers/${P}.tar.gz"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

COMMON_DEPEND=">=app-crypt/trousers-0.3.0"
RDEPEND="${COMMON_DEPEND}
	nls? ( virtual/libintl )"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i -e "s/-Werror //" configure.in || die "Sed failed"
	eautoreconf
}

src_configure() {
	econf $(use_enable nls) \
		--disable-pkcs11-support
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die
}
