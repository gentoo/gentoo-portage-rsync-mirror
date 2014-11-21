# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsecp256k1/libsecp256k1-9999.ebuild,v 1.1 2014/11/21 11:42:50 blueness Exp $

EAPI=5

EGIT_REPO_URI="https://github.com/bitcoin/secp256k1.git"
inherit git-2 autotools

DESCRIPTION="Optimized C library for EC operations on curve secp256k1"
HOMEPAGE="https://github.com/bitcoin/secp256k1"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="asm doc endomorphism test"

REQUIRED_USE="
	asm? ( amd64 )
"
RDEPEND="
	dev-libs/gmp
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-4.7
	asm? ( dev-lang/yasm )
	test? ( dev-libs/openssl )
"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-benchmark \
		$(use_enable test tests) \
		$(use_enable endomorphism)  \
		--with-field=$(usex asm 64bit_asm $(usex amd64 64bit gmp)) \
		--disable-static
}

src_compile() {
	emake
}

src_test() {
	emake check
}

src_install() {
	if use doc; then
		dodoc README.md
	fi

	emake DESTDIR="${D}" install
	prune_libtool_files
}
