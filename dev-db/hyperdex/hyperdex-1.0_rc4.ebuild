# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hyperdex/hyperdex-1.0_rc4.ebuild,v 1.2 2013/05/10 08:12:19 patrick Exp $
EAPI=4

PYTHON_DEPEND="2:2.6"
inherit eutils python

DESCRIPTION="A searchable distributed Key-Value Store"

MY_P="${P/_/.}"
S="${WORKDIR}/${MY_P}"

HOMEPAGE="http://hyperdex.org"
SRC_URI="http://hyperdex.org/src/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+python"
# need to add ruby and java useflags too

DEPEND="dev-cpp/glog
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
