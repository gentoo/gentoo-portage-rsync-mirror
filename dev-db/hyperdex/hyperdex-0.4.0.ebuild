# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hyperdex/hyperdex-0.4.0.ebuild,v 1.4 2012/08/20 13:33:23 patrick Exp $
EAPI=4

PYTHON_DEPEND="2:2.6"
inherit eutils python

DESCRIPTION="A searchable distributed Key-Value Store"

HOMEPAGE="http://hyperdex.org"
SRC_URI="http://hyperdex.org/src/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="trace-player +python"
# need to add coverage and java useflags too

DEPEND="dev-cpp/glog
	dev-libs/cityhash
	dev-libs/libpo6
	dev-libs/libe
	dev-libs/busybee
	dev-libs/popt
	trace-player? ( dev-libs/libbsd )"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# file has moved
	sed -i -e 's:vis.h:bsd/vis.h:' trace-player.cc || die "Failed to fix include file path"
}

src_configure() {
	econf \
		$(use_enable trace-player) \
		$(use_enable python python-bindings)
}

src_install() {
	emake DESTDIR="${D}" install || die "Failed to install"
	newinitd "${FILESDIR}/hyperdex.initd" hyperdex || die "Failed to install init script"
	newconfd "${FILESDIR}/hyperdex.confd" hyperdex || die "Failed to install config file"
}
