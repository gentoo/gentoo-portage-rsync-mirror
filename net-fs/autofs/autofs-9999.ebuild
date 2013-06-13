# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-9999.ebuild,v 1.2 2013/06/13 15:03:59 robbat2 Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true
AUTOTOOLS_IN_SOURCE_BUILD=1

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git"
inherit autotools-utils linux-info multilib git-2

DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="-dmalloc hesiod ldap libtirpc mount-locking sasl"

# USE="sasl" adds SASL support to the LDAP module which will not be build. If
# SASL support should be available, please add "ldap" to the USE flags.
REQUIRED_USE="sasl? ( ldap )"

# currently, sasl code assumes the presence of kerberosV
RDEPEND=">=sys-apps/util-linux-2.20
	hesiod? ( net-dns/hesiod )
	ldap? ( >=net-nds/openldap-2.0
		sasl? (
			dev-libs/cyrus-sasl
			dev-libs/libxml2
			virtual/krb5
		)
	)
	libtirpc? ( net-libs/libtirpc )"

DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc"

CONFIG_CHECK="~AUTOFS4_FS"

src_prepare() {
	epatch_user
	autotools-utils_src_prepare
}

src_configure() {
	# --with-confdir is for bug #361481
	# --with-mapdir is for bug #385113
	# for systemd support (not enabled yet):
	#   --with-systemd
	#   --disable-move-mount: requires kernel >=2.6.39
	local myeconfargs=(
		--with-confdir=/etc/conf.d
		--with-mapdir=/etc/autofs
		$(use_with dmalloc)
		$(use_with ldap openldap)
		$(use_with libtirpc)
		$(use_with sasl)
		$(use_with hesiod)
		$(use_enable mount-locking)
		--disable-ext-env
		--enable-sloppy-mount
		--enable-forced-shutdown
		--enable-ignore-busy
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if kernel_is -lt 2 6 30; then
		# kernel patches
		docinto patches
		dodoc patches/${PN}4-2.6.??{,.?{,?}}-v5-update-????????.patch
	fi
	newinitd "${FILESDIR}"/autofs5.initd autofs
	insinto etc/autofs
	newins "${FILESDIR}"/autofs5-auto.master auto.master
}

pkg_postinst() {
	if kernel_is -lt 2 6 30; then
		elog "This version of ${PN} requires a kernel with autofs4 supporting"
		elog "protocol version 5.00. Patches for kernels older than 2.6.30 have"
		elog "been installed into"
		elog "${EROOT}usr/share/doc/${P}/patches."
		elog "For further instructions how to patch the kernel, please refer to"
		elog "${EROOT}usr/share/doc/${P}/INSTALL."
		elog
	fi
	elog "If you plan on using autofs for automounting remote NFS mounts,"
	elog "please check that both portmap (or rpcbind) and rpc.statd/lockd"
	elog "are running."
}
