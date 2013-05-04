# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.0.7-r1.ebuild,v 1.2 2013/05/04 17:18:38 vapier Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils linux-info multilib

PATCH_VER=2
[[ -n ${PATCH_VER} ]] && \
	PATCHSET_URI="http://dev.gentoo.org/~jlec/distfiles/${P}-patches-${PATCH_VER}.tar.lzma"

DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI="
	mirror://kernel/linux/daemons/${PN}/v5/${P}.tar.bz2
	${PATCHSET_URI}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="hesiod ldap mount-locking sasl"

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
	)"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc"

PATCHES=(
	# Fix for bug #210762
	# Upstream reference: http://thread.gmane.org/gmane.linux.kernel.autofs/4203
	"${FILESDIR}"/${PN}-5.0.3-heimdal.patch

	# Accumulated fixes for bugs
	#    #154797: Respect CC and CFLAGS
	#    #253412: Respect LDFLAGS
	#    #247969: Link order for --as-needed
	"${FILESDIR}"/${PN}-5.0.6-respect-user-flags-and-fix-asneeded-r2.patch

	# Upstream reference: http://thread.gmane.org/gmane.linux.kernel.autofs/5371
	"${FILESDIR}"/${PN}-5.0.5-fix-install-deadlink.patch

	"${FILESDIR}"/${PN}-5.0.5-add-missing-endif-HAVE_SASL-in-modules-lookup_ldap.c.patch #361899
	"${FILESDIR}"/${PN}-5.0.6-revert-ldap.patch #381315
	"${FILESDIR}"/${PN}-5.0.7-mount-sloppy.patch #453778
	)

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	# Upstream's patchset
	if [[ -n ${PATCH_VER} ]]; then
		EPATCH_SUFFIX="patch" \
			epatch "${WORKDIR}"/patches
	fi
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
		$(use_with ldap openldap)
		$(use_with sasl)
		$(use_with hesiod)
		$(use_enable mount-locking)
		--enable-ignore-busy
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	# kernel patches
	docinto patches
	dodoc patches/${PN}4-2.6.??{,.?{,?}}-v5-update-????????.patch

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
