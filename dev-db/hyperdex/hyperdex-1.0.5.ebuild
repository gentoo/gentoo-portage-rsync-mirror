# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hyperdex/hyperdex-1.0.5.ebuild,v 1.2 2014/02/10 06:52:47 patrick Exp $
EAPI=5

PYTHON_DEPEND="2:2.6"
inherit eutils python

DESCRIPTION="A searchable distributed Key-Value Store"

HOMEPAGE="http://hyperdex.org"
SRC_URI="http://hyperdex.org/src/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+python"
# need to add ruby and java useflags too

DEPEND="dev-cpp/glog
	dev-cpp/sparsehash
	dev-libs/cityhash
	dev-libs/libpo6
	dev-libs/libe
	dev-libs/busybee
	dev-libs/popt
	dev-libs/replicant"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	econf --disable-static \
		$(use_enable python python-bindings)
}

src_install() {
	emake DESTDIR="${D}" install || die "Failed to install"
	newinitd "${FILESDIR}/hyperdex.initd" hyperdex || die "Failed to install init script"
	newconfd "${FILESDIR}/hyperdex.confd" hyperdex || die "Failed to install config file"
	find "${D}" -name '*.la' -exec rm {} \; # bad buildsystem! bad!
}
