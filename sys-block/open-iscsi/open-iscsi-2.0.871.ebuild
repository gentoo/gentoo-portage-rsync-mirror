# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/open-iscsi-2.0.871.ebuild,v 1.5 2012/02/25 06:30:10 robbat2 Exp $

inherit versionator linux-mod eutils flag-o-matic

DESCRIPTION="Open-iSCSI is a high performance, transport independent, multi-platform implementation of RFC3720"
HOMEPAGE="http://www.open-iscsi.org/"
MY_PV="${PN}-$(replace_version_separator 2 "-" $MY_PV)"
SRC_URI="http://www.open-iscsi.org/bits/${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~mips"
IUSE="utils debug"
DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}
		sys-apps/util-linux"

S="${WORKDIR}/${MY_PV}"

MODULE_NAMES_ARG="kernel/drivers/scsi:${S}/kernel"
MODULE_NAMES="iscsi_tcp(${MODULE_NAMES_ARG}) scsi_transport_iscsi(${MODULE_NAMES_ARG}) libiscsi(${MODULE_NAMES_ARG})"
BUILD_TARGETS="all"
CONFIG_CHECK="CRYPTO_CRC32C"
CONFIG_CHECK_MODULES="SCSI_ISCSI_ATTRS ISCSI_TCP"
ERROR_CFG="open-iscsi needs CRC32C support in your kernel."

pkg_setup() {
	linux-info_pkg_setup
	linux-mod_pkg_setup

	# Needs to be done, as iscsid currently only starts, when having the iSCSI
	# support loaded as module. Kernel builtion options don't work. See this for
	# more information:
	# http://groups.google.com/group/open-iscsi/browse_thread/thread/cc10498655b40507/fd6a4ba0c8e91966
	# If there's a new release, check whether this is still valid!

	for module in ${CONFIG_CHECK_MODULES}; do
		linux_chkconfig_module ${module} || ewarn "${module} needs to be built as module (builtin doesn't work)"
	done
}

src_unpack() {
	unpack ${A}
	export EPATCH_OPTS="-d${S}"
	if kernel_is -lt 2 6 16; then
		die "Sorry, your kernel must be 2.6.16-rc5 or newer!"
	fi
	epatch "${FILESDIR}"/CVE-2009-1297.patch
}

src_compile() {
	use debug && append-flags -DDEBUG_TCP -DDEBUG_SCSI

	einfo "Building userspace"
	cd "${S}" && \
	CFLAGS="" emake OPTFLAGS="${CFLAGS}" user \
		|| die "emake failed"
}

src_install() {
	einfo "Installing userspace"
	dosbin usr/iscsid usr/iscsiadm usr/iscsistart

	if use utils; then
		einfo "Installing utilities"
		dosbin utils/iscsi-iname utils/iscsi_discovery
	fi

	einfo "Installing docs"
	doman doc/*[1-8]
	dodoc README THANKS
	docinto test
	dodoc test/*

	einfo "Installing configuration"
	insinto /etc/iscsi
	doins etc/iscsid.conf
	insinto /etc/iscsi/ifaces
	doins etc/iface.example

	# only contains iscsi initiatorname, no need to update
	if [ ! -e /etc/iscsi/initiatorname.iscsi ]; then
		doins "${FILESDIR}"/initiatorname.iscsi
	fi

	# if there is a special conf.d for this version, use it
	# otherwise, use the default: iscsid-conf.d
	insinto /etc/conf.d
	if [ -e "${FILESDIR}"/iscsid-${PV}.conf.d ]; then
		newins "${FILESDIR}"/iscsid-${PV}.conf.d iscsid
	else
		newins "${FILESDIR}"/iscsid-conf.d iscsid
	fi

	# same for init.d
	if [ -e "${FILESDIR}"/iscsid-${PV}.init.d ]; then
		newinitd "${FILESDIR}"/iscsid-${PV}.init.d iscsid
	else
		newinitd "${FILESDIR}"/iscsid-init.d iscsid
	fi

	keepdir /var/db/iscsi
	fperms 700 /var/db/iscsi
	fperms 600 /etc/iscsi/iscsid.conf
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
