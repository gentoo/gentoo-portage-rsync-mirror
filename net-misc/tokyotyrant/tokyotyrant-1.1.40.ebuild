# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tokyotyrant/tokyotyrant-1.1.40.ebuild,v 1.2 2014/01/08 06:30:37 vapier Exp $

EAPI=2

inherit eutils user

DESCRIPTION="A network interface to Tokyo Cabinet"
HOMEPAGE="http://1978th.net/tokyotyrant/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-macos"
IUSE="debug lua"

DEPEND="dev-db/tokyocabinet
	sys-libs/zlib
	app-arch/bzip2
	lua? ( dev-lang/lua )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use !prefix ; then
		enewgroup tyrant
		enewuser tyrant -1 -1 /var/lib/${PN} tyrant
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/fix_makefiles.patch
	epatch "${FILESDIR}"/fix_testsuite.patch
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable lua)
}

src_install() {
	rm ttservctl || die "Install failed"
	emake DESTDIR="${D}" install || die "Install failed"

	for x in /var/{lib,run,log}/${PN}; do
		dodir "${x}" || die "Install failed"
		use prefix || fowners tyrant:tyrant "${x}"
	done

	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die "Install failed"
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die "Install failed"

}

src_test() {
	emake -j1 check || die "Tests failed"
}
