# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eclass-manpages/eclass-manpages-20120718.ebuild,v 1.1 2012/07/18 14:27:54 vapier Exp $

DESCRIPTION="collection of Gentoo eclass manpages"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_compile() {
	bash "${FILESDIR}"/eclass-to-manpage.sh || die
}

src_install() {
	doman *.5 || die
}
