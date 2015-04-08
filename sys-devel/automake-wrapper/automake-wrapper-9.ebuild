# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake-wrapper/automake-wrapper-9.ebuild,v 1.11 2014/01/17 04:23:05 vapier Exp $

DESCRIPTION="wrapper for automake to manage multiple automake versions"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

S=${WORKDIR}

src_unpack() {
	cp "${FILESDIR}"/am-wrapper-${PV}.sh "${S}"/
	# usr/bin/aclocal: bad substitution -> /bin/sh != POSIX shell
	if use prefix ; then
		sed -i -e '1c\#!'"${EPREFIX}"'/bin/sh' "${S}"/am-wrapper-${PV}.sh || die
	fi
}

src_install() {
	newbin "${S}"/am-wrapper-${PV}.sh automake || die
	dosym automake /usr/bin/aclocal

	keepdir /usr/share/aclocal
}
