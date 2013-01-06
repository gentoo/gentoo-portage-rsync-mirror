# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-3.0.9.ebuild,v 1.11 2012/08/18 15:38:05 vapier Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="http://rsync.samba.org/"
SRC_URI="http://rsync.samba.org/ftp/rsync/src/${P/_/}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="acl iconv ipv6 static xattr"

RDEPEND=">=dev-libs/popt-1.5
	acl? ( virtual/acl )
	xattr? ( kernel_linux? ( sys-apps/attr ) )
	iconv? ( virtual/libiconv )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/_/}

src_prepare() {
	epatch_user
}

src_configure() {
	use static && append-ldflags -static
	econf \
		--without-included-popt \
		$(use_enable acl acl-support) \
		$(use_enable xattr xattr-support) \
		$(use_enable ipv6) \
		$(use_enable iconv) \
		--with-rsyncd-conf=/etc/rsyncd.conf
	touch proto.h-tstamp #421625
}

src_install() {
	emake DESTDIR="${D}" install || die
	newconfd "${FILESDIR}"/rsyncd.conf.d rsyncd
	newinitd "${FILESDIR}"/rsyncd.init.d rsyncd || die
	dodoc NEWS OLDNEWS README TODO tech_report.tex
	insinto /etc
	doins "${FILESDIR}"/rsyncd.conf || die

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/rsyncd.logrotate rsyncd

	insinto /etc/xinetd.d
	newins "${FILESDIR}"/rsyncd.xinetd rsyncd

	# Install the useful contrib scripts
	exeinto /usr/share/rsync
	doexe support/* || die
	rm -f "${D}"/usr/share/rsync/{Makefile*,*.c}
}

pkg_postinst() {
	if egrep -qis '^[[:space:]]use chroot[[:space:]]*=[[:space:]]*(no|0|false)' \
		"${ROOT}"/etc/rsyncd.conf "${ROOT}"/etc/rsync/rsyncd.conf ; then
		ewarn "You have disabled chroot support in your rsyncd.conf.  This"
		ewarn "is a security risk which you should fix.  Please check your"
		ewarn "/etc/rsyncd.conf file and fix the setting 'use chroot'."
	fi
}
