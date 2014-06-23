# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/openstack-guest-agents-unix/openstack-guest-agents-unix-1.39.0.ebuild,v 1.2 2014/06/23 05:39:51 patrick Exp $

EAPI=5

inherit autotools eutils vcs-snapshot

DESCRIPTION="Openstack Unix Guest Agent"
HOMEPAGE="http://github.com/rackerlabs/openstack-guest-agents-unix"
SRC_URI="https://github.com/rackerlabs/${PN}-unix/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-util/patchelf
	dev-python/pycrypto
	dev-python/pyxenstore
	"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	doinitd scripts/gentoo/nova-agent
}
