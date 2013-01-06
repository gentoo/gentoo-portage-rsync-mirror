# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvswitch/openvswitch-1.6.1-r2.ebuild,v 1.1 2012/07/18 08:41:29 dev-zero Exp $

EAPI=4

PYTHON_DEPEND="monitor? 2"

inherit eutils linux-info python

DESCRIPTION="Production quality, multilayer virtual switch."
HOMEPAGE="http://openvswitch.org"
SRC_URI="http://openvswitch.org/releases/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug monitor +pyside +ssl"

RDEPEND="ssl? ( dev-libs/openssl )
	monitor? ( dev-python/twisted
		dev-python/twisted-conch
		dev-python/twisted-web
		pyside? ( dev-python/pyside )
		!pyside? ( dev-python/PyQt4 )
		net-zope/zope-interface )
	debug? ( dev-lang/perl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="~NET_CLS_ACT ~NET_CLS_U32 ~NET_SCH_INGRESS ~NET_ACT_POLICE ~IPV6 ~TUN ~OPENVSWITCH"

pkg_setup() {
	linux-info_pkg_setup
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	set_arch_to_kernel
	use monitor || export ovs_cv_python="no"
	use pyside || export ovs_cv_pyuic4="no"
	local modconf
	econf ${modconf} \
		--with-rundir=/var/run/openvswitch \
		--with-logdir=/var/log/openvswitch \
		--with-pkidir=/etc/openvswitch/pki \
		$(use_enable ssl) \
		$(use_enable !debug ndebug)
}

src_compile() {
	default

	use monitor && python_convert_shebangs 2 \
		utilities/ovs-{pcap,tcpundump,test,vlan-test} \
		utilities/bugtool/ovs-bugtool \
		ovsdb/ovsdbmonitor/ovsdbmonitor
}

src_install() {
	default

	if use monitor ; then
		insinto $(python_get_sitedir)
		doins -r "${D}"/usr/share/openvswitch/python/*
		rm -r "${D}/usr/share/openvswitch/python"
	fi
	# not working without the brcompat_mod kernel module which did not get
	# included in the kernel and we can't build it anymore
	rm "${D}/usr/sbin/ovs-brcompatd" "${D}/usr/share/man/man8/ovs-brcompatd.8"

	keepdir /var/log/openvswitch
	keepdir /etc/openvswitch/pki

	rm -rf "${D}/var/run"
	use monitor || rmdir "${D}/usr/share/openvswitch/ovsdbmonitor"
	use debug || rm "${D}/usr/bin/ovs-parse-leaks"

	newconfd "${FILESDIR}/ovsdb-server_conf" ovsdb-server
	newconfd "${FILESDIR}/ovs-vswitchd_conf" ovs-vswitchd
	newconfd "${FILESDIR}/ovs-controller_conf" ovs-controller
	doinitd "${FILESDIR}/ovsdb-server"
	doinitd "${FILESDIR}/ovs-vswitchd"
	doinitd "${FILESDIR}/ovs-controller"

	insinto /etc/logrotate.d
	newins rhel/etc_logrotate.d_openvswitch openvswitch
}

pkg_postinst() {
	use monitor && python_mod_optimize /usr/share/openvswitch/ovsdbmonitor ovs ovstest

	elog "Use the following command to create an initial database for ovsdb-server:"
	elog "   emerge --config =${CATEGORY}/${PF}"
	elog "(will create a database in /etc/openvswitch/conf.db)"
	elog "or to convert the database to the current schema after upgrading."
}

pkg_postrm() {
	use monitor && python_mod_cleanup /usr/share/openvswitch/ovsdbmonitor ovs ovstest
}

pkg_config() {
	local db="${PREFIX}/etc/openvswitch/conf.db"
	if [ -e "${db}" ] ; then
		einfo "Database '${db}' already exists, doing schema migration..."
		einfo "(if the migration fails, make sure that ovsdb-server is not running)"
		"${PREFIX}/usr/bin/ovsdb-tool" convert "${db}" "${PREFIX}/usr/share/openvswitch/vswitch.ovsschema" || die "converting database failed"
	else
		einfo "Creating new database '${db}'..."
		"${PREFIX}/usr/bin/ovsdb-tool" create "${db}" "${PREFIX}/usr/share/openvswitch/vswitch.ovsschema" || die "creating database failed"
	fi
}
