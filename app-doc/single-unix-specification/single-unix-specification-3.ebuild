# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/single-unix-specification/single-unix-specification-3.ebuild,v 1.4 2010/10/19 09:10:31 leio Exp $

DESCRIPTION="The Single UNIX Specification, Version 3, 2004 Edition (8 Volumes)"
HOMEPAGE="http://www.opengroup.org/bookstore/catalog/t041.htm"
SRC_URI="http://www.opengroup.org/onlinepubs/009695399/download/susv3.tar.bz2"

LICENSE="as-is"
SLOT="3"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""

S="${WORKDIR}/susv3"

src_install() {
	insinto /usr/share/doc/${PF}/html
	doins -r * || die "doins"
}
