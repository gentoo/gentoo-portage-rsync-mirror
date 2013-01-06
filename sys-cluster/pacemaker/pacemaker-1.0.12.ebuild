# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pacemaker/pacemaker-1.0.12.ebuild,v 1.2 2012/07/11 16:05:16 mr_bones_ Exp $

EAPI="2"

MY_PN=Pacemaker
MY_P=${MY_PN}-${PV}
PYTHON_DEPEND="2"

inherit autotools base python

MY_TREE="066152e"

DESCRIPTION="Pacemaker CRM"
HOMEPAGE="http://www.linux-ha.org/wiki/Pacemaker"
SRC_URI="https://github.com/ClusterLabs/${PN}-1.0/tarball/${MY_P} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="+ais heartbeat smtp snmp static-libs"

DEPEND="
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-cluster/cluster-glue
	sys-cluster/resource-agents
	heartbeat? ( >=sys-cluster/heartbeat-3.0.0 )
	!heartbeat? ( sys-cluster/corosync )
	smtp? ( net-libs/libesmtp )
	snmp? ( net-analyzer/net-snmp )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.10-asneeded.patch"
	"${FILESDIR}/${PN}-1.0.10-installpaths.patch"
	"${FILESDIR}/1.0.12-BUILD_VERSION.patch"
)

S="${WORKDIR}/ClusterLabs-${PN}-1.0-${MY_TREE}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	base_src_prepare
	sed -i -e "/ggdb3/d" configure.ac || die
	sed -e "s:<glib/ghash.h>:<glib.h>:" \
		-i lib/ais/plugin.c || die
	eautoreconf
}

src_configure() {
	local myopts=""
	use heartbeat || myopts="--with-ais"
	# appends lib to localstatedir automatically
	econf \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--disable-fatal-warnings \
		$(use_with heartbeat) \
		$(use_with smtp esmtp) \
		$(use_with snmp) \
		$(use_enable static-libs static) \
		${myopts}
}

src_install() {
	base_src_install
	use static-libs || find "${D}" -type f -name "*.la" -delete
}
