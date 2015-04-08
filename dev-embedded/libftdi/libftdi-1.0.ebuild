# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftdi/libftdi-1.0.ebuild,v 1.3 2013/12/09 05:24:42 vapier Exp $

EAPI="4"

inherit cmake-utils eutils

MY_P="${PN}1-${PV}"
if [[ ${PV} == 9999* ]] ; then
	EGIT_REPO_URI="git://developer.intra2net.com/${PN}"
	inherit git-2
else
	SRC_URI="http://www.intra2net.com/en/developer/${PN}/download/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
fi

DESCRIPTION="Userspace access to FTDI USB interface chips"
HOMEPAGE="http://www.intra2net.com/en/developer/libftdi/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="cxx doc examples python static-libs tools"

RDEPEND="virtual/libusb:1
	cxx? ( dev-libs/boost )
	python? ( dev-lang/python )
	tools? ( dev-libs/confuse )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0-staticlibs.patch
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use cxx FTDIPP)
		$(cmake-utils_use doc DOCUMENTATION)
		$(cmake-utils_use examples EXAMPLES)
		$(cmake-utils_use python PYTHON_BINDINGS)
		$(cmake-utils_use static-libs STATICLIBS)
		$(cmake-utils_use tools FTDI_EEPROM)
		-DCMAKE_SKIP_BUILD_RPATH=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog README TODO

	if use doc ; then
		# Clean up crap man pages. #356369
		rm -vf "${CMAKE_BUILD_DIR}"/doc/man/man3/{_,usb_,deprecated}*

		doman "${CMAKE_BUILD_DIR}"/doc/man/man3/*
		dohtml "${CMAKE_BUILD_DIR}"/doc/html/*
	fi
	if use examples ; then
		docinto examples
		dodoc examples/*.c
	fi
}
