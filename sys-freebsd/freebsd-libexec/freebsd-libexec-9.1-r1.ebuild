# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-libexec/freebsd-libexec-9.1-r1.ebuild,v 1.1 2013/06/18 17:06:33 aballier Exp $

EAPI=5

inherit bsdmk freebsd pam multilib multibuild

DESCRIPTION="FreeBSD libexec things"
SLOT="0"
KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"

SRC_URI="mirror://gentoo/${LIBEXEC}.tar.bz2
	mirror://gentoo/${UBIN}.tar.bz2
	mirror://gentoo/${BIN}.tar.bz2
	mirror://gentoo/${CONTRIB}.tar.bz2
	mirror://gentoo/${LIB}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2
	mirror://gentoo/${USBIN}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	>=sys-freebsd/freebsd-lib-9.1-r6[multilib?]
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*"
RDEPEND="${RDEPEND}
	xinetd? ( sys-apps/xinetd )"

S="${WORKDIR}/libexec"

# Remove sendmail, tcp_wrapper and other useless stuff
REMOVE_SUBDIRS="smrsh mail.local tcpd telnetd rshd rlogind lukemftpd ftpd"

IUSE="pam ssl kerberos ipv6 multilib nis xinetd"

MULTIBUILD_VARIANTS=( $(get_all_abis) )

pkg_setup() {
	use ipv6 || mymakeopts="${mymakeopts} WITHOUT_INET6= WITHOUT_INET6_SUPPORT= "
	use kerberos || mymakeopts="${mymakeopts} WITHOUT_KERBEROS_SUPPORT= "
	use nis || mymakeopts="${mymakeopts} WITHOUT_NIS= "
	use pam || mymakeopts="${mymakeopts} WITHOUT_PAM_SUPPORT= "
	use ssl || mymakeopts="${mymakeopts} WITHOUT_OPENSSL= "

	mymakeopts="${mymakeopts} WITHOUT_SENDMAIL= WITHOUT_PF= WITHOUT_RCMDS= "
}

src_prepare() {
	ln -s /usr/include "${WORKDIR}/include"
}

setup_multilib_vars() {
	if use multilib && [ "${ABI}" != "${DEFAULT_ABI}" ] ; then
		cd "${WORKDIR}/libexec/rtld-elf" || die
		export mymakeopts="${mymakeopts} PROG=ld-elf32.so.1"
	else
		cd "${S}"
	fi
	"$@"
}

src_compile() {
	multibuild_foreach_variant freebsd_multilib_multibuild_wrapper setup_multilib_vars freebsd_src_compile
}

src_install() {
	multibuild_foreach_variant freebsd_multilib_multibuild_wrapper setup_multilib_vars freebsd_src_install

	insinto /etc
	doins "${WORKDIR}/etc/gettytab"
	newinitd "${FILESDIR}/bootpd.initd" bootpd
	newconfd "${FILESDIR}/bootpd.confd" bootpd

	if use xinetd; then
		for rpcd in rstatd rusersd walld rquotad sprayd; do
			insinto /etc/xinetd.d
			newins "${FILESDIR}/${rpcd}.xinetd" ${rpcd}
		done
	fi
}
