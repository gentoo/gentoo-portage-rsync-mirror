# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftdi/libftdi-0.20.ebuild,v 1.3 2012/09/11 06:36:29 vapier Exp $

EAPI="2"

inherit cmake-utils python

if [[ ${PV} == 9999* ]] ; then
	EGIT_REPO_URI="git://developer.intra2net.com/${PN}"
	inherit git-2 autotools
else
	SRC_URI="http://www.intra2net.com/en/developer/${PN}/download/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
fi

DESCRIPTION="Userspace access to FTDI USB interface chips"
HOMEPAGE="http://www.intra2net.com/en/developer/libftdi/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="cxx doc examples python"

RDEPEND="virtual/libusb:0
	cxx? ( dev-libs/boost )
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i \
		-e "s:[$]{PYTHON_LIB_INSTALL}/../site-packages:$(python_get_sitedir):" \
		bindings/CMakeLists.txt || die
	sed -i \
		-e '/SET(LIB_SUFFIX /d' \
		CMakeLists.txt || die
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use cxx FTDIPP)
		$(cmake-utils_use doc DOCUMENTATION)
		$(cmake-utils_use examples EXAMPLES)
		$(cmake-utils_use python PYTHON_BINDINGS)
		-DCMAKE_SKIP_BUILD_RPATH=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog README

	if use doc ; then
		doman doc/man/man3/*
		dohtml doc/html/*
	fi
	if use examples ; then
		docinto examples
		dodoc examples/*.c
	fi
}
