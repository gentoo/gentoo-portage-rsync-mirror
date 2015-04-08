# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/single-unix-specification/single-unix-specification-4-r1.ebuild,v 1.10 2013/10/20 20:17:38 grobian Exp $

DESCRIPTION="The Single UNIX Specification, Version 4, 2008 Edition (8 Volumes)"
HOMEPAGE="http://www.opengroup.org/bookstore/catalog/c082.htm"
SRC_URI="http://www.opengroup.org/onlinepubs/9699919799/download/susv4.tar.bz2"

LICENSE="sus4-copyright"
SLOT="4"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~x64-macos"
IUSE=""

S=${WORKDIR}/susv4

src_install() {
	dohtml -r * || die "dohtml"
}

pkg_postinst() {
	elog "Open /usr/share/doc/${PF}/html/index.html in a browser to access these docs."
}
