# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-tools/tpm-tools-1.3.5-r1.ebuild,v 1.4 2012/12/23 18:20:22 vapier Exp $

EAPI=4
inherit autotools eutils flag-o-matic

DESCRIPTION="TrouSerS' support tools for the Trusted Platform Modules"
HOMEPAGE="http://trousers.sourceforge.net"
SRC_URI="mirror://sourceforge/trousers/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="nls pkcs11 debug"

COMMON_DEPEND="
	>=app-crypt/trousers-0.3.0
	dev-libs/openssl
	pkcs11? ( dev-libs/opencryptoki )
	"
RDEPEND="${COMMON_DEPEND}
	nls? ( virtual/libintl )"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i -r \
		-e '/CFLAGS/s/ -(Werror|m64)//' \
		configure.in || die
	epatch "${FILESDIR}"/${PN}-1.3.1-gold.patch

	eautoreconf
}

src_configure() {
	local myconf
	# don't use --enable-pkcs11-support, configure is a mess.
	use pkcs11 || myconf+=" --disable-pkcs11-support"

	append-flags $(usex debug -DDEBUG -DNDEBUG)

	econf \
		$(use_enable nls) \
		${myconf}
}
