# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdivecomputer/libdivecomputer-0.3.0.ebuild,v 1.1 2013/03/28 18:32:41 tomwij Exp $

EAPI="5"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://libdivecomputer.git.sourceforge.net/gitroot/libdivecomputer/libdivecomputer"
	GIT_ECLASS="git-2"
	AUTOTOOLIZE=yes
fi

inherit eutils autotools-utils ${GIT_ECLASS}

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
else
	SRC_URI="http://www.divesoftware.org/libdc/releases/${P}.tar.gz"
fi

DESCRIPTION="Library for communication with dive computers from various manufacturers."
HOMEPAGE="http://www.divesoftware.org/libdc"
LICENSE="LGPL-2.1"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="usb examples +static-libs"

RDEPEND="usb? ( virtual/libusb )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	if [[ -n ${AUTOTOOLIZE} ]]; then
		eautoreconf
	fi
}

src_configure() {
	autotools-utils_src_configure

	if use usb ; then
		sed -i 's|#define HAVE_LIBUSB 1||' config.h || die "sed failed"
	fi

	if use examples ; then
		sed -i 's|examples||' Makefile || die "sed failed"
	fi
}

src_compile() {
	autotools-utils_src_compile
}

src_install() {
	autotools-utils_src_install
}
