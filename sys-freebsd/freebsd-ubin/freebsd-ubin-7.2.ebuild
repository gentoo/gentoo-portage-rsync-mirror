# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-ubin/freebsd-ubin-7.2.ebuild,v 1.3 2009/10/08 08:00:32 aballier Exp $

EAPI=2

inherit bsdmk freebsd flag-o-matic pam

DESCRIPTION="FreeBSD's base system source for /usr/bin"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

SRC_URI="mirror://gentoo/${UBIN}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2
		mirror://gentoo/${BIN}.tar.bz2
		mirror://gentoo/${INCLUDE}.tar.bz2
		build? ( mirror://gentoo/${SYS}.tar.bz2 )"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*[usb?,bluetooth?]
	ssl? ( dev-libs/openssl )
	kerberos? ( virtual/krb5 )
	virtual/pam
	sys-libs/zlib
	!dev-util/csup"

DEPEND="${RDEPEND}
	sys-devel/flex
	!build? ( =sys-freebsd/freebsd-sources-${RV}* )
	=sys-freebsd/freebsd-mk-defs-${RV}*"

RDEPEND="${RDEPEND}
	>=sys-auth/pambase-20080219.1
	sys-process/cronbase"

S="${WORKDIR}/usr.bin"

IUSE="atm audit bluetooth ipv6 kerberos netware nis ssl usb build"

pkg_setup() {
	use atm || mymakeopts="${mymakeopts} WITHOUT_ATM= "
	use audit || mymakeopts="${mymakeopts} WITHOUT_AUDIT= "
	use bluetooth || mymakeopts="${mymakeopts} WITHOUT_BLUETOOTH= "
	use ipv6 || mymakeopts="${mymakeopts} WITHOUT_INET6= WITHOUT_INET6_SUPPORT= "
	use kerberos || mymakeopts="${mymakeopts} WITHOUT_KERBEROS_SUPPORT= "
	use netware || mymakeopts="${mymakeopts} WITHOUT_IPX= WITHOUT_IPX_SUPPORT= WITHOUT_NCP= "
	use nis || mymakeopts="${mymakeopts} WITHOUT_NIS= "
	use ssl || mymakeopts="${mymakeopts} WITHOUT_OPENSSL= "
	use usb || mymakeopts="${mymakeopts} WITHOUT_USB= "
}

# List of patches to apply
PATCHES=( "${FILESDIR}/${PN}-6.0-bsdcmp.patch"
	"${FILESDIR}/${PN}-6.0-fixmakefiles.patch"
	"${FILESDIR}/${PN}-setXid.patch"
	"${FILESDIR}/${PN}-lint-stdarg.patch"
	"${FILESDIR}/${PN}-6.0-kdump-ioctl.patch" )

# Here we remove some sources we don't need because they are already
# provided by portage's packages or similar. In order:
# - Archiving tools, provided by their own ebuilds
# - ncurses stuff
# - less stuff
# - bind utils
# - rsh stuff
# - binutils gprof
# and the rest are misc utils we already provide somewhere else.
REMOVE_SUBDIRS="bzip2 bzip2recover tar
	gzip gprof
	tput tset
	less lessecho lesskey
	dig hesinfo nslookup nsupdate host
	rsh rlogin rusers rwho ruptime
	compile_et lex vi smbutil file vacation nc ftp telnet
	c99 c89
	whois tftp"

pkg_preinst() {
	# bison installs a /usr/bin/yacc symlink ...
	# we need to remove it to avoid triggering
	# collision-protect errors
	if [[ -L ${ROOT}/usr/bin/yacc ]] ; then
		rm -f "${ROOT}"/usr/bin/yacc
	fi
}

src_prepare() {
	use build || ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"

	# Rename manpage for renamed cmp
	mv "${S}"/cmp/cmp.1 "${S}"/cmp/bsdcmp.1
	# Fix whereis(1) manpath search.
	sed -i -e 's:"manpath -q":"manpath":' "${S}/whereis/pathnames.h"

	# Build a dynamic make
	sed -i -e '/^NO_SHARED/ s/^/#/' "${S}"/make/Makefile
}

src_install() {
	freebsd_src_install

	# baselayout requires these in /bin
	dodir /bin
	for bin in sed; do
		mv "${D}/usr/bin/${bin}" "${D}/bin/" || die "mv ${bin} failed"
		dosym /bin/${bin} /usr/bin/${bin} || die "dosym ${bin} failed"
	done

	for pamdfile in login passwd su; do
		newpamd "${FILESDIR}/${pamdfile}.1.pamd" ${pamdfile}
	done

	cd "${WORKDIR}/etc"
	insinto /etc
	doins remote phones opieaccess fbtab

	exeinto /etc/cron.daily
	newexe "${FILESDIR}/locate-updatedb-cron" locate.updatedb
}

pkg_postinst() {
	# We need to ensure that login.conf.db is up-to-date.
	if [[ -e "${ROOT}"etc/login.conf ]] ; then
		einfo "Updating ${ROOT}etc/login.conf.db"
		"${ROOT}"usr/bin/cap_mkdb	-f "${ROOT}"etc/login.conf "${ROOT}"etc/login.conf
		elog "Remember to run cap_mkdb /etc/login.conf after making changes to it"
	fi
}

pkg_postrm() {
	# and if we uninstall yacc but keep bison,
	# lets restore the /usr/bin/yacc symlink
	if [[ ! -e ${ROOT}/usr/bin/yacc ]] && [[ -e ${ROOT}/usr/bin/yacc.bison ]] ; then
		ln -s yacc.bison "${ROOT}"/usr/bin/yacc
	fi
}
