# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libuv/libuv-0.11.25-r1.ebuild,v 1.6 2015/03/05 02:23:17 hasufell Exp $

EAPI=5

inherit eutils autotools multilib-minimal

DESCRIPTION="A new platform layer for Node"
HOMEPAGE="https://github.com/libuv/libuv"
SRC_URI="https://github.com/libuv/libuv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD BSD-2 ISC MIT"
SLOT="0/11"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

DEPEND="virtual/pkgconfig"

src_prepare() {
	echo "m4_define([UV_EXTRA_AUTOMAKE_FLAGS], [serial-tests])" \
		> m4/libuv-extra-automake-flags.m4 || die

	epatch "${FILESDIR}"/0{1,2}-${P}-tests.patch

	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static)
}

multilib_src_test() {
	mkdir "${BUILD_DIR}"/test || die
	cp -pPR "${S}"/test/fixtures "${BUILD_DIR}"/test/fixtures || die
	default
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files
}
