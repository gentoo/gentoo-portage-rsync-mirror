# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/nss_wrapper/nss_wrapper-1.0.3.ebuild,v 1.1 2015/03/08 13:08:27 polynomial-c Exp $

EAPI=5

inherit cmake-utils multilib-minimal

DESCRIPTION="A wrapper for the user, group and hosts NSS API"
HOMEPAGE="https://cwrap.org/nss_wrapper.html"
SRC_URI="ftp://ftp.samba.org/pub/cwrap/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"

multilib_src_configure() {
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

multilib_src_install() {
	cmake-utils_src_install
}
