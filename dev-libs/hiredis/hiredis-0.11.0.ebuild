# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hiredis/hiredis-0.11.0.ebuild,v 1.2 2013/08/07 02:06:32 neurogeek Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="Minimalistic C client library for the Redis database"
HOMEPAGE="http://github.com/redis/hiredis"
SRC_URI="http://github.com/redis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

DOCS="CHANGELOG.md README.md"

src_prepare() {
	epatch "${FILESDIR}/${P}-disable-network-tests.patch"
}

src_compile() {

	if ! use debug; then
		emake CC="$(tc-getCC)" ARCH= DEBUG=
	else
		emake CC="$(tc-getCC)" ARCH=
	fi
}

src_test() {
	emake test
}

src_install() {
	emake PREFIX="${ED}/usr" LIBRARY_PATH="$(get_libdir)"  install
	dodoc ${DOCS}
}
