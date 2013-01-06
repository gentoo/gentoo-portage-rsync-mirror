# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-4.1.4-r1.ebuild,v 1.6 2012/02/29 13:13:05 ranger Exp $

EAPI="4"

inherit eutils multilib autotools

PATCH_VER="1"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI="mirror://kernel/linux/daemons/${PN}/v4/${P}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="hesiod ldap"

DEPEND="hesiod? ( net-dns/hesiod )
	ldap? ( >=net-nds/openldap-2.0 )"
RDEPEND="${DEPEND}"

UPSTREAM_FILESDIR="gentoo/${CATEGORY}/${PN}/files"

src_prepare() {
	EPATCH_SUFFIX="patch" \
		epatch "${WORKDIR}"/patches

	# Accumulated fixes for bugs
	#    #154797: Respect CC and CFLAGS
	#    #253412: Respect LDFLAGS
	#    #247969: Link order for --as-needed
	epatch "${FILESDIR}"/${P}-respect-user-flags-and-fix-asneeded.patch

	# Reflect init script implementation
	epatch "${FILESDIR}"/${P}-fix-man-pages.patch

	# Use Gentoo specific maps, init script and config file
	for i in home master misc; do
		if [ -e samples/auto.${i} ]; then
			mv samples/auto.${i}{,.bak} || die "Failed to backup auto.${i}"
		fi
		ln -s "${S}/${UPSTREAM_FILESDIR}"/auto.${i} samples/auto.${i} || \
			die "Failed to symlink auto.${i}"
	done

	# Clean-up maps and disable everything.
	epatch "${FILESDIR}"/${P}-clean-up-maps.patch

	# Fix installation path of ldap samples and maps
	epatch "${FILESDIR}"/${P}-fix-install-ldap-samples-and-maps.patch

	epatch "${FILESDIR}"/${P}-init.patch #Fix init script deps

	# Do not include <nfs/nfs.h>, rather <linux/nfs.h>,
	# as the former is a lame header for the latter (bug #157968)
	sed 's@nfs/nfs.h@linux/nfs.h@' -i lib/rpc_subs.c || die

	eautoreconf
}

src_configure() {
	# work around bug #355975 (mount modifies timestamp of /etc/mtab)
	# with >=sys-apps/util-linux-2.19,
	addpredict "/etc/mtab"

	econf \
		$(use_with ldap openldap) \
		$(use_with hesiod)
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc README* CHANGELOG CREDITS COPYRIGHT

	newinitd ${UPSTREAM_FILESDIR}/${PN}.init ${PN}
	newconfd ${UPSTREAM_FILESDIR}/${PN}.conf ${PN}
}

pkg_postinst() {
	elog "If you plan on using autofs for automounting remote NFS mounts,"
	elog "please check that both portmap (or rpcbind) and rpc.statd/lockd"
	elog "are running."
	elog
	elog "Also the normal autofs status has been renamed stats"
	elog "as there is already a predefined Gentoo status"
	if use ldap; then
		elog
		elog "Sample files for ldap have been installed into"
		elog "${PREFIX}/usr/share/share/doc/${P}/samples."
	fi
}
