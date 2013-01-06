# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/deb2targz/deb2targz-1-r2.ebuild,v 1.9 2012/07/25 15:42:31 darkside Exp $

EAPI=4
inherit base

DESCRIPTION="Convert a .deb file to a .tar.gz archive"
HOMEPAGE="http://www.miketaylor.org.uk/tech/deb/"
SRC_URI="http://www.miketaylor.org.uk/tech/deb/${PN}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~ppc-aix ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

S=${WORKDIR}
PATCHES=( "${FILESDIR}/${PN}-any-data.patch" )

src_unpack() {
	cp "${DISTDIR}/${PN}" "${S}"
}

src_install() {
	dobin ${PN}
}
