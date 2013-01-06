# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.0.3-r6.ebuild,v 1.10 2012/04/25 16:29:19 jlec Exp $

inherit eutils multilib autotools

IUSE="ldap sasl"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v5"
# This list is taken directly from http://kernel.org/pub/linux/daemons/autofs/v5/patch_order-5.0.3
# Please do not modify the order
PATCH_LIST="
	${P}-ldap-page-control-configure-fix.patch
	${P}-xfn-not-supported.patch
	${P}-basedn-with-spaces-fix-3.patch
	${P}-nfs4-tcp-only.patch
	${P}-correct-ldap-lib.patch
	${P}-dont-fail-on-empty-master-fix-2.patch
	${P}-expire-works-too-hard.patch
	${P}-unlink-mount-return-fix.patch
	${P}-update-linux-auto_fs4-h.patch
	${P}-expire-works-too-hard-update.patch
	${P}-expire-works-too-hard-update-2.patch
	${P}-handle-zero-length-nis-key.patch
	${PN}-5.0.2-init-cb-on-load.patch
	${P}-map-type-in-map-name.patch
	${P}-mount-thread-create-cond-handling.patch
	${P}-check-for-kernel-automount.patch
	${P}-nss-source-any.patch
	${P}-dont-abuse-ap-ghost-field.patch
	${P}-lookup-next-soucre-stale-entry.patch
	${P}-remove-redundant-dns-name-lookups.patch
	${P}-mount-thread-create-cond-handling-fix.patch
	${P}-allow-dir-create-on-nfs-root.patch
	${P}-check-direct-path-len.patch
	${P}-fix-get-user-info-check.patch
	${P}-fix-couple-of-memory-leaks.patch
	${P}-override-is-running-check.patch
	${P}-dont-use-proc-for-is-running-check.patch
	${P}-fix-included-browse-map-not-found.patch
	${P}-fix-multi-source-messages.patch
	${P}-clear-stale-on-map-read.patch
	${P}-fix-proximity-other-timeout.patch
	${P}-refactor-mount-request-vars.patch
	${P}-make-handle_mounts-startup-cond-distinct.patch
	${P}-submount-shutdown-recovery-12.patch
	${P}-dont-block-on-expire.patch
	${P}-add-umount_wait-parameter.patch
	${P}-fix-multi-mount-race.patch
	${P}-submount-shutdown-recovery-12-fix.patch
	${P}-fix-nfs4-colon-escape.patch
	${P}-check-replicated-list-after-probe.patch
	${P}-add-replicated-debug-logging.patch
	${P}-update-replicated-doco.patch
	${P}-use-dev-urandom.patch
	${P}-mtab-as-proc-mounts.patch
	${P}-fix-ifc-buff-size.patch
	${P}-fix-percent-hack.patch
	${P}-fix-ifc-buff-size-fix.patch
	${P}-mtab-as-proc-mounts-fix.patch"
SRC_URI="${SRC_URI_BASE}/${P}.tar.bz2"
for i in ${PATCH_LIST} ; do
	SRC_URI="${SRC_URI} ${SRC_URI_BASE}/${i}"
done ;
DEPEND="ldap? ( >=net-nds/openldap-2.0 )
	sasl? ( virtual/krb5 )"
	# currently, sasl code assumes the presence of kerberosV
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86"

src_unpack() {
	unpack ${P}.tar.bz2
	for i in ${PATCH_LIST}; do
		cp ${DISTDIR}/${i} ${T}
	done
	patch "${T}"/${P}-map-type-in-map-name.patch \
		< "${FILESDIR}"/${P}-map-patch-fix.patch || die "failed to patch"
	for i in ${PATCH_LIST}; do
		EPATCH_OPTS="-p1 -d ${S}" epatch ${T}/${i}
		rm -f ${T}/${i}
	done

	# fixes bug #210762
	epatch "${FILESDIR}"/${P}-heimdal.patch

	cd "${S}"

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
	CFLAGS="${CFLAGS}" \
	econf \
		$(use_with ldap openldap) \
		$(use_with sasl) \
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
