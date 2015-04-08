# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fleet/fleet-9999.ebuild,v 1.4 2014/12/07 20:30:55 alunduil Exp $

EAPI=5

inherit git-r3 systemd

EGIT_REPO_URI="git://github.com/coreos/fleet.git"

DESCRIPTION="A Distributed init System"
HOMEPAGE="https://github.com/coreos/fleet"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="doc examples"

DEPEND=">=dev-lang/go-1.3"
RDEPEND=""

src_compile() {
	./build || die 'Build failed'
}

RESTRICT="test"  # Tests fail due to Gentoo bug #500452
src_test() {
	./test || die 'Tests failed'
}

src_install() {
	dobin "${S}"/bin/fleetd
	dobin "${S}"/bin/fleetctl

	systemd_dounit "${FILESDIR}"/fleetd.service

	dodoc README.md
	use doc && dodoc -r Documentation
	use examples && dodoc -r examples

	keepdir /etc/${PN}
	insinto /etc/${PN}
	newins "${PN}".conf.sample "${PN}".conf
}

pkg_postinst() {
	ewarn "If you're upgrading from a version less than 0.8.0, please read the messages!"
	elog "The fleet binary name changed to fleetd."
	elog "If you're using systemd, update your configuration:"
	elog "  systemctl disable fleet; systemctl enable fleetd"
}
