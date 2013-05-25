# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libconfig/libconfig-1.4.9-r1.ebuild,v 1.7 2013/05/25 08:02:25 ago Exp $

EAPI=5
inherit eutils autotools-multilib

DESCRIPTION="Libconfig is a simple library for manipulating structured configuration files"
HOMEPAGE="http://www.hyperrealm.com/libconfig/libconfig.html"
SRC_URI="http://www.hyperrealm.com/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86 ~x86-linux"
IUSE="+cxx examples static-libs"

DEPEND="
	sys-devel/libtool
	sys-devel/bison"

PATCHES=( "${FILESDIR}/${P}-out-of-source-build.patch" )

AUTOTOOLS_AUTORECONF="1"

src_prepare() {
	sed -i configure.ac -e 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' || die
	autotools-multilib_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable cxx)
		--disable-examples
	)
	autotools-multilib_src_configure
}

local_src_test() {
	pushd "${BUILD_DIR}" > /dev/null || die
	emake test || die "test failed"
	popd > /dev/null || die
}

src_test() {
	# It responds to check but that does not work as intended
	multilib_foreach_abi local_src_test
}

src_install() {
	autotools-multilib_src_install
	if use examples; then
		local dir
		for dir in examples/c examples/c++; do
			insinto /usr/share/doc/${PF}/${dir}
			doins ${dir}/*
		done
	fi
}
