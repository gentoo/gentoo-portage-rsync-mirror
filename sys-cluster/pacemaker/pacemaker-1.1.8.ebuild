# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pacemaker/pacemaker-1.1.8.ebuild,v 1.3 2012/11/14 17:24:22 jer Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit autotools base python

MY_PN=Pacemaker
MY_P=${MY_PN}-${PV}
MY_TREE="1f8858c"

DESCRIPTION="Pacemaker CRM"
HOMEPAGE="http://www.linux-ha.org/wiki/Pacemaker"
SRC_URI="https://github.com/ClusterLabs/${PN}/tarball/${MY_P} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
REQUIRED_USE="cman? ( !heartbeat )"
IUSE="acl cman heartbeat smtp snmp static-libs"

DEPEND="
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-cluster/cluster-glue
	>=sys-cluster/libqb-0.14.0
	sys-cluster/resource-agents
	cman? ( sys-cluster/cman )
	heartbeat? ( >=sys-cluster/heartbeat-3.0.0 )
	!heartbeat? ( sys-cluster/corosync )
	smtp? ( net-libs/libesmtp )
	snmp? ( net-analyzer/net-snmp )
"
RDEPEND="${DEPEND}"
PDEPEND="sys-cluster/crmsh"

PATCHES=(
	"${FILESDIR}"/${PV}-backwards_compatibility.patch
	)

S="${WORKDIR}/ClusterLabs-${PN}-${MY_TREE}"

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
	python_convert_shebangs -r 2 .
}

src_configure() {
	local myopts=""
	use heartbeat || myopts="--with-ais"
	# appends lib to localstatedir automatically
	econf \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--disable-fatal-warnings \
		$(use_with acl) \
		$(use_with cman cs-quorum) \
		$(use_with cman cman) \
		$(use_with heartbeat) \
		$(use_with smtp esmtp) \
		$(use_with snmp) \
		$(use_enable static-libs static) \
		${myopts}
}

src_install() {
	base_src_install
	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
	if has_version "<sys-cluster/corosync-2.0"; then
		insinto /etc/corosync/service.d
		newins "${FILESDIR}/${PN}.service" ${PN} || die
	fi
}
