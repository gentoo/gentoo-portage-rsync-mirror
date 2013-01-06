# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5-appl/mit-krb5-appl-1.0.3.ebuild,v 1.9 2012/12/16 19:42:35 ulm Exp $

EAPI=4

inherit flag-o-matic versionator eutils

MY_P=${P/mit-}
MAJOR_MINOR="$( get_version_component_range 1-2 )"
DESCRIPTION="Kerberized applications split from the main MIT Kerberos V distribution"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5-appl/${MAJOR_MINOR}/${MY_P}-signed.tar"

LICENSE="openafs-krb5-a BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND=">=app-crypt/mit-krb5-1.8.0
	sys-libs/e2fsprogs-libs
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	unpack ./"${MY_P}".tar.gz
}

src_configure() {
	append-flags "-I/usr/include/et"
	append-flags -fno-strict-aliasing
	append-flags -fno-strict-overflow
	econf
}

src_install() {
	emake DESTDIR="${D}" install
	for i in {telnetd,ftpd} ; do
		mv "${D}"/usr/share/man/man8/${i}.8 "${D}"/usr/share/man/man8/k${i}.8 \
		|| die "mv failed (man)"
		mv "${D}"/usr/sbin/${i} "${D}"/usr/sbin/k${i} || die "mv failed"
	done

	for i in {rcp,rlogin,rsh,telnet,ftp} ; do
		mv "${D}"/usr/share/man/man1/${i}.1 "${D}"/usr/share/man/man1/k${i}.1 \
		|| die "mv failed (man)"
		mv "${D}"/usr/bin/${i} "${D}"/usr/bin/k${i} || die "mv failed"
	done

	rm "${D}"/usr/share/man/man1/tmac.doc
	dodoc README
}
