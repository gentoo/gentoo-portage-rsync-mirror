# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-4.1.3-r7.ebuild,v 1.8 2012/04/25 16:29:19 jlec Exp $

inherit eutils multilib

IUSE="ldap"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v4"
SRC_URI="${SRC_URI_BASE}/${P}.tar.bz2
		${SRC_URI_BASE}/${P}-strict.patch
		${SRC_URI_BASE}/${P}-mtab_lock.patch
		${SRC_URI_BASE}/${P}-bad_chdir.patch
		${SRC_URI_BASE}/${P}-non_block_ping.patch
		${SRC_URI_BASE}/${P}-sock-leak-fix.patch
		${SRC_URI_BASE}/${P}-replicated_server_select.patch
		mirror://gentoo/${P}-miscfixes.patch.gz"
DEPEND="ldap? ( >=net-nds/openldap-2.0 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc x86"

src_unpack() {
	unpack ${P}.tar.bz2
	PATCH_LIST="${P}-strict.patch ${P}-mtab_lock.patch ${P}-bad_chdir.patch ${P}-non_block_ping.patch ${P}-sock-leak-fix.patch ${P}-replicated_server_select.patch ${P}-miscfixes.patch.gz"
	for i in ${PATCH_LIST}; do
		EPATCH_OPTS="-p1 -d ${S}" epatch ${DISTDIR}/${i}
	done

	# Upstream version of this patch is incorrect
	epatch "${FILESDIR}"/${P}-signal-race-fix.patch

	cd ${S}
	autoconf || die "Autoconf failed"

	cd ${S}/daemon
	sed -i 's/LIBS \= \-ldl/LIBS \= \-ldl \-lnsl \$\{LIBLDAP\}/' Makefile \
		|| die "LIBLDAP change failed"

	cd ${S}/lib
	sed -i '/^listmount.o:/s,$, mount.h,g' Makefile \
		|| die "Failed to fix dependencies"
}

src_compile() {
	local myconf
	use ldap || myconf="--without-openldap"

	econf ${myconf} || die
	sed -i -e '/^\(CFLAGS\|CXXFLAGS\|LDFLAGS\)[[:space:]]*=/d' Makefile.rules || die "Failed to remove (C|CXX|LD)FLAGS"
	emake || die "make failed"
}

src_install() {
	into /usr
	dosbin daemon/automount
	exeinto /usr/$(get_libdir)/autofs
	doexe modules/*.so

	dodoc COPYING COPYRIGHT NEWS README* TODO CHANGELOG CREDITS
	cd ${S}/samples
	docinto samples ; dodoc auto.misc auto.master
	cd ${S}/man
	sed -i 's:\/etc\/:\/etc\/autofs\/:g' *.8 *.5 *.in || die "Failed to update path in manpages"
	doman auto.master.5 autofs.5 autofs.8 automount.8

	insinto /etc/autofs ; doins ${FILESDIR}/auto.master
	insinto /etc/autofs ; doins ${FILESDIR}/auto.misc
	exeinto /etc/autofs ; doexe ${FILESDIR}/auto.net # chmod 755 is important!

	newinitd ${FILESDIR}/autofs.rc11 autofs
	newconfd ${FILESDIR}/autofs.confd9 autofs
	if use ldap; then
		cd ${S}/samples
		docinto samples ; dodoc ldap* auto.master.ldap
		insinto /etc/openldap/schema ; doins autofs.schema
		exeinto /usr/$(get_libdir)/autofs ; doexe autofs-ldap-auto-master
	fi
}

pkg_postinst() {
	elog "Note: If you plan on using autofs for automounting"
	elog "remote NFS mounts without having the NFS daemon running"
	elog "please add portmap to your default run-level."
	elog
	elog "Also the normal autofs status has been renamed stats"
	elog "as there is already a predefined Gentoo status"
}
