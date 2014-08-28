# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fleet/fleet-9999.ebuild,v 1.2 2014/08/28 15:28:18 alunduil Exp $

EAPI=5

inherit git-2 systemd

EGIT_REPO_URI="git://github.com/coreos/fleet.git"

DESCRIPTION="A Distributed init System"
HOMEPAGE="https://github.com/coreos/fleet"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-lang/go-1.2"
RDEPEND=""

src_compile() {
	./build || die
}

src_install() {
	dobin "${S}"/bin/fleetd
	dobin "${S}"/bin/fleetctl

	systemd_dounit "${FILESDIR}"/${PN}.service
}
