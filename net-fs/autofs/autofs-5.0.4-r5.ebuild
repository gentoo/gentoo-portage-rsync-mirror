# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.0.4-r5.ebuild,v 1.10 2012/04/25 16:29:19 jlec Exp $

inherit eutils multilib autotools

IUSE="ldap sasl"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v5"
# This list is taken directly from http://kernel.org/pub/linux/daemons/autofs/v5/patch_order-${PV}
# Please do not modify the order
PATCH_LIST="
	${P}-fix-dumb-libxml2-check.patch
	${P}-expire-specific-submount-only.patch
	${P}-fix-negative-cache-non-existent-key.patch
	${P}-fix-ldap-detection.patch
	${P}-use-CLOEXEC-flag.patch
	${P}-fix-select-fd-limit.patch
	${P}-make-hash-table-scale-to-thousands-of-entries.patch
	${P}-fix-quoted-mess.patch
	${P}-use-CLOEXEC-flag-setmntent.patch
	${P}-fix-hosts-map-use-after-free.patch
	${P}-uris-list-locking-fix.patch
	${P}-renew-sasl-creds-upon-reconnect-fail.patch
	${P}-library-reload-fix-update.patch
	${P}-force-unlink-umount.patch
	${P}-always-read-file-maps.patch
	${P}-code-analysis-corrections.patch
	${P}-make-MAX_ERR_BUF-and-PARSE_MAX_BUF-use-easier-to-audit.patch
	${P}-easy-alloca-replacements.patch
	${P}-configure-libtirpc.patch
	${P}-ipv6-name-and-address-support.patch
	${P}-ipv6-parse.patch
	${P}-add-missing-changelog-entries.patch
	${P}-use-CLOEXEC-flag-setmntent-include-fix.patch
	${P}-easy-alloca-replacements-fix.patch
	${P}-libxml2-workaround-fix.patch
	${P}-configure-libtirpc-fix.patch
	${P}-add-nfs-mount-proto-default-conf-option.patch
	${P}-fix-bad-token-declare.patch
	${P}-fix-return-start-status-on-fail.patch
	${P}-fix-double-free-in-expire_proc.patch
	${P}-another-easy-alloca-replacements-fix.patch
	${P}-add-lsb-init-script-parameter-block.patch
	${P}-always-read-file-maps-fix.patch
	${P}-use-misc-device.patch
	${P}-fix-restorecon.patch
	${P}-clear-rpc-client-on-lookup-fail.patch
	${P}-fix-lsb-init-script-header.patch
	${P}-fix-memory-leak-reading-ldap-master.patch
	${P}-fix-st_remove_tasks-locking.patch
	${P}-reset-flex-scanner-when-setting-buffer.patch
	${P}-zero-s_magic-is-valid.patch
	${P}-use-percent-hack-for-master.patch
	${P}-use-intr-as-hosts-mount-default.patch
	${P}-fix-kernel-includes.patch
	${P}-dont-umount-existing-direct-mount-on-reread.patch
	${P}-library-reload-fix-update-fix.patch
	${P}-improve-manual-umount-recovery.patch
	${P}-dont-fail-on-ipv6-address-adding-host.patch
	${P}-always-read-file-maps-multi-map-fix.patch
	${P}-always-read-file-maps-key-lookup-fixes.patch
	${P}-use-srv-query-for-domain-dn.patch
	${P}-fix-incorrect-dclist-free.patch
	${P}-srv-lookup-handle-endian.patch
	${P}-library-reload-fix-update-fix-2.patch
	${P}-fix-notify-mount-message-path.patch
	${P}-remount-we-created-mount-point-fix.patch
	${P}-fix-double-free-in-do_sasl_bind.patch
	${P}-manual-umount-recovery-fixes.patch
	${P}-fix-map-type-info-parse-error.patch"
SRC_URI="${SRC_URI_BASE}/${P}.tar.bz2"
for i in ${PATCH_LIST} ; do
	SRC_URI="${SRC_URI} ${SRC_URI_BASE}/${i}"
done ;
DEPEND="ldap? ( >=net-nds/openldap-2.0
		sasl? ( dev-libs/cyrus-sasl
			virtual/krb5
			dev-libs/libxml2 )
	)"
	# currently, sasl code assumes the presence of kerberosV
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86"

src_unpack() {
	unpack ${P}.tar.bz2
	for i in ${PATCH_LIST}; do
		EPATCH_OPTS="-p1 -d ${S}" epatch "${DISTDIR}"/${i}
	done

	cd "${S}"

	# fixes bug #210762
	epatch "${FILESDIR}"/${PN}-5.0.3-heimdal.patch

	# fixes bugs #253412 and #247969
	epatch "${FILESDIR}"/${P}-user-ldflags-and-as-needed-v2.patch

	# # use CC and CFLAGS from environment (bug #154797)
	# write these values in Makefile.conf
	(echo "# Use the compiler and cflags determined by configure";
	echo "CC := @CC@"; echo "CFLAGS := @CFLAGS@") >> Makefile.conf.in
	# make sure Makefile.conf is parsed after Makefile.rules
	sed -ni '/include Makefile.conf/{x; n; G}; p' Makefile
	sed -i 's/^\(CC\|CXX\).*//' Makefile.rules
	sed -i 's/^CFLAGS=-fPIE.*//' configure.in

	# do not include <nfs/nfs.h>, rather <linux/nfs.h>,
	# as the former is a lame header for the latter (bug #157968)
	sed -i 's@nfs/nfs.h@linux/nfs.h@' include/rpc_subs.h

	eautoreconf
}

src_compile() {
	# work around bug #355975 (mount modifies timestamp of /etc/mtab)
	# with >=sys-apps/util-linux-2.19,
	addpredict "/etc/mtab"

	CFLAGS="${CFLAGS}" \
	econf \
		$(use_with ldap openldap) \
		$(use_with sasl) \
		--without-hesiod \
		--enable-ignore-busy

	emake DONTSTRIP=1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}"/autofs5.rc1 autofs
}

pkg_postinst() {
	elog "Note: If you plan on using autofs for automounting"
	elog "remote NFS mounts without having the NFS daemon running"
	elog "please add portmap to your default run-level."
}
