# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-8.0_beta2.ebuild,v 1.3 2014/10/17 09:12:09 jlec Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1738/${P/_beta/+beta}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="ldap"

RDEPEND="
	>=dev-libs/glib-2.16
	>=dev-libs/hiredies-0.10.1
	=net-libs/gnutls-2*
	net-libs/libpcap
	app-crypt/gpgme
	!net-analyzer/openvas-libnasl
	>=net-libs/libssh-0.5.0
	ldap? (	net-nds/openldap )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	dev-util/cmake"

S="${WORKDIR}"/${P/_beta/+beta}

DOCS=( ChangeLog CHANGES README )

PATCHES=(
	"${FILESDIR}"/${PN}-7.0.4-libssh.patch
	"${FILESDIR}"/${PN}-7.0.4-bsdsource.patch
	"${FILESDIR}"/${P}-underlinking.patch
	)

src_configure() {
	local mycmakeargs=(
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
		$(cmake-utils_use_build ldap WITH_LDAP)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
