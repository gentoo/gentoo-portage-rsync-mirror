# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bestcrypt/bestcrypt-1.7.0.ebuild,v 1.4 2013/03/02 21:49:24 alonbl Exp $

EAPI="2"

inherit eutils flag-o-matic linux-mod toolchain-funcs versionator

MY_PN="bcrypt"
MY_PV="$(replace_version_separator 2 -)"
DESCRIPTION="commercially licensed transparent filesystem encryption"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BestCrypt-${MY_PV}.tar.gz"

LICENSE="bestcrypt"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${MY_PV}"

pkg_setup() {
	linux-mod_pkg_setup

	MODULE_NAMES="bc(block:mod)
		bc_3des(block:mod:mod/3des)
		bc_bf128(block:mod:mod/bf128)
		bc_bf448(block:mod:mod/bf448)
		bc_blowfish(block:mod:mod/blowfish)
		bc_cast(block:mod:mod/cast)
		bc_des(block:mod:mod/des)
		bc_gost(block:mod:mod/gost)
		bc_idea(block:mod:mod/idea)
		bc_rijn(block:mod:mod/rijn)
		bc_twofish(block:mod:mod/twofish)"
	BUILD_TARGETS="all"
	BUILD_PARAMS=" \
		CPP=\"$(tc-getCXX)\" \
		KERNEL_DIR=\"${KV_DIR}\" \
		VER=${KV_MAJOR}.${KV_MINOR} \
		KEXT=${KV_OBJ}"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-respect_LDFLAGS.patch"
}

src_compile() {
	linux-mod_src_compile

	filter-flags -fforce-addr

	emake BC_CPP="$(tc-getCXX)" EXTRA_CFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	linux-mod_src_install

	dobin build/bctool
	dolib.so build/lib{bccore,kgsha{,256}}.so
	local link
	for link in bcmount bcumount bcformat bcfsck bcnew bcpasswd bcinfo bclink bcunlink bcmake_hidden bcreencrypt; do
		dosym bctool "/usr/bin/${link}"
	done
	insinto /etc
	newins etc/bc.conf bc.conf
	newinitd "${FILESDIR}/bcrypt3" bcrypt
	sed -e '/\(bc_rc6\|bc_serpent\)/d' -i "${D}etc/init.d/bcrypt"
	dodoc HIDDEN_PART README
	doman man/bctool.8
}

pkg_postinst() {
	ewarn
	ewarn "The BestCrypt drivers are not free - Please purchace a license from "
	ewarn "http://www.jetico.com/"
	ewarn

	linux-mod_pkg_postinst
}
