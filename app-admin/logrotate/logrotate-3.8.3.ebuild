# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.8.3.ebuild,v 1.11 2013/01/01 19:29:18 armin76 Exp $

EAPI=4

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="https://fedorahosted.org/logrotate/"
SRC_URI="https://fedorahosted.org/releases/l/o/logrotate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="acl selinux"

RDEPEND="
	>=dev-libs/popt-1.5
	selinux? (
		sys-libs/libselinux
		sec-policy/selinux-logrotate
	)
	acl? ( virtual/acl )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-datehack.patch \
		"${FILESDIR}"/${P}-ignore-hidden.patch \
		"${FILESDIR}"/${P}-fbsd.patch \
		"${FILESDIR}"/${P}-noasprintf.patch \
		"${FILESDIR}"/${P}-atomic-create.patch \
		"${FILESDIR}"/${P}-fix-acl-tests.patch
}

src_configure() {
	return
}

src_compile() {
	local myconf
	myconf="CC=$(tc-getCC)"
	use selinux && myconf="${myconf} WITH_SELINUX=yes"
	use acl && myconf="${myconf} WITH_ACL=yes"
	emake ${myconf} RPM_OPT_FLAGS="${CFLAGS}"
}

src_test() {
	WITH_ACL="$(usev acl)" default_src_test
}

src_install() {
	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc CHANGES examples/logrotate*

	exeinto /etc/cron.daily
	doexe "${FILESDIR}"/logrotate.cron

	insinto /etc
	doins "${FILESDIR}"/logrotate.conf

	keepdir /etc/logrotate.d
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "If you wish to have logrotate e-mail you updates, please"
		elog "emerge virtual/mailx and configure logrotate in"
		elog "/etc/logrotate.conf appropriately"
		elog
		elog "Additionally, /etc/logrotate.conf may need to be modified"
		elog "for your particular needs.  See man logrotate for details."
	fi
}
