# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/open-iscsi-2.0.871.3.ebuild,v 1.8 2012/02/01 14:21:56 ranger Exp $

EAPI=2
inherit versionator linux-info eutils flag-o-matic

DESCRIPTION="Open-iSCSI is a high performance, transport independent, multi-platform implementation of RFC3720"
HOMEPAGE="http://www.open-iscsi.org/"
SRC_URI="mirror://kernel/linux/kernel/people/mnc/open-iscsi/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~mips ppc x86"
IUSE="debug"
DEPEND=""
RDEPEND="${DEPEND}
		sys-apps/util-linux"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is -lt 2 6 16; then
		die "Sorry, your kernel must be 2.6.16-rc5 or newer!"
	fi

	# Needs to be done, as iscsid currently only starts, when having the iSCSI
	# support loaded as module. Kernel builtion options don't work. See this for
	# more information:
	# http://groups.google.com/group/open-iscsi/browse_thread/thread/cc10498655b40507/fd6a4ba0c8e91966
	# If there's a new release, check whether this is still valid!
	CONFIG_CHECK_MODULES="SCSI_ISCSI_ATTRS ISCSI_TCP"
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_module ${module} || ewarn "${module} needs to be built as module (builtin doesn't work)"
		done
	fi
}

src_prepare() {
	export EPATCH_OPTS="-d${S}"
	epatch "${FILESDIR}"/CVE-2009-1297.patch
	epatch "${FILESDIR}"/${PN}-2.0.871-makefile-cleanup.patch
	epatch "${FILESDIR}"/${P}-glibc212.patch
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

	einfo "Installing utilities"
	dosbin utils/iscsi-iname utils/iscsi_discovery

	einfo "Installing docs"
	doman doc/*[1-8]
	dodoc README THANKS
	docinto test
	dodoc test/*

	einfo "Installing configuration"
	insinto /etc/iscsi
	doins etc/iscsid.conf
	newins "${FILESDIR}"/initiatorname.iscsi initiatorname.iscsi.example
	insinto /etc/iscsi/ifaces
	doins etc/iface.example

	newconfd "${FILESDIR}"/iscsid-conf.d iscsid
	newinitd "${FILESDIR}"/iscsid-2.0.871-r1.init.d iscsid

	keepdir /var/db/iscsi
	fperms 700 /var/db/iscsi
	fperms 600 /etc/iscsi/iscsid.conf
}

pkg_postinst() {
	in='/etc/iscsi/initiatorname.iscsi'
	if [ ! -f "${ROOT}${in}" -a -f "${ROOT}${in}.example" ]; then
		cp -f "${ROOT}${in}.example" "${ROOT}${in}"
	fi
}
