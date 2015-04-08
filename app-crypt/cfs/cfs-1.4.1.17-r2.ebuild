# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cfs/cfs-1.4.1.17-r2.ebuild,v 1.3 2013/01/21 19:06:31 ulm Exp $

inherit eutils versionator

MY_PV="$(get_version_component_range 1-3)"
DEB_PV="$(get_version_component_range 4)"

# This is a port of the Debian port of CFS which includes several
# useful patches.  Many thanks to the Debian developers.

DESCRIPTION="Cryptographic Filesystem"
HOMEPAGE="http://packages.debian.org/stable/utils/cfs
	http://www.crypto.com/software/"
SRC_URI="mirror://debian/pool/main/c/cfs/cfs_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/c/cfs/cfs_${MY_PV}-${DEB_PV}.diff.gz"

LICENSE="CFS BSD SSLeay GPL-2"	# GPL-2 only for initscript
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="net-fs/nfs-utils"

S=${WORKDIR}/${PN}-${MY_PV}.orig

# Originally from the common-lisp-common.eclass:

do-debian-credits() {
	docinto debian
	for i in copyright README.Debian changelog; do
		# be silent, since all files are not always present
		dodoc "${S}"/debian/${i} &>/dev/null || true
	done
	docinto .
}

cfsd-running() {
	test -n "$(mount |grep '\(/var/cfs\|/var/lib/cfs/\.cfsfs\)')"
}

pkg_setup() {
	if cfsd-running; then
		eerror "It seems that the null directory or CFS root is currently in use."
		eerror "You must shutdown CFS before merging this port or at least unmount"
		eerror "the CFS root before using this port."
		die "cfs is still running!"
	fi
}

src_unpack() {
	unpack ${A}
	epatch cfs_${MY_PV}-${DEB_PV}.diff
}

src_compile() {
	make cfs COPT="${CFLAGS} -DPROTOTYPES -g" || die "make failed!"
}

src_install() {
	make install_cfs BINDIR="${D}"/usr/bin ETCDIR="${D}"/usr/sbin || \
		die "make install failed!"
	newconfd "${FILESDIR}"/cfsd.conf cfsd
#	exeinto /var/lib/cfs
#	doexe debian/cfs_*mount.sh
	keepdir /var/run/cfs
	keepdir /var/cfs
	keepdir /var/lib/cfs/.cfsfs
	chmod 0 "${D}"/var/lib/cfs/.cfsfs
	doman *.[18]
	newinitd "${FILESDIR}"/cfsd.init cfsd
	do-debian-credits
	dodoc LEVELS README* VERSION
	dodoc "${FILESDIR}"/README.Gentoo
}

pkg_postinst() {
	rm -f /var/lib/cfs/.cfsfs/.keep
	einfo "Please read the Gentoo README in /usr/share/doc/${PF}/ for"
	einfo "information on how to get started with CFS on Gentoo."
}
