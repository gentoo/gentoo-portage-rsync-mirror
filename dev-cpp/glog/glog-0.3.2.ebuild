# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/glog/glog-0.3.2.ebuild,v 1.5 2013/01/10 20:40:38 vapier Exp $

EAPI="4"
inherit eutils

DESCRIPTION="Google's C++ logging library"
HOMEPAGE="http://code.google.com/p/google-glog/"
SRC_URI="http://google-glog.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="gflags static-libs unwind test"

RDEPEND="gflags? ( dev-cpp/gflags )
	unwind? ( sys-libs/libunwind )"
DEPEND="${RDEPEND}
	test? (
		dev-cpp/gmock
		dev-cpp/gtest
	)"

src_prepare() {
	epatch "${FILESDIR}"/${P}-avoid-inline-asm.patch
}

src_configure() {
	export ac_cv_lib_gflags_main=$(usex gflags)
	export ac_cv_lib_unwind_backtrace=$(usex unwind)
	use test || export ac_cv_prog_GTEST_CONFIG=no
	econf \
		--docdir="\${datarootdir}/doc/${PF}" \
		--htmldir="\${datarootdir}/doc/${PF}/html" \
		$(use_enable static-libs static)
}

src_install() {
	default

	# Punt docs we don't care about (NEWS is 0 bytes).
	rm "${ED}"/usr/share/doc/${PF}/{COPYING,NEWS,README.windows}

	# --htmldir doesn't work (yet):
	# https://code.google.com/p/google-glog/issues/detail?id=144
	dohtml "${ED}"/usr/share/doc/${PF}/*
	rm "${ED}"/usr/share/doc/${PF}/*.{html,css}

	use static-libs || find "${ED}" -name '*.la' -delete
}
