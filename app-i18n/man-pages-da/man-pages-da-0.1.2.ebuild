# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-da/man-pages-da-0.1.2.ebuild,v 1.1 2011/08/20 18:16:52 mattst88 Exp $

EAPI=4

DESCRIPTION="A somewhat comprehensive collection of Danish Linux man pages"
HOMEPAGE="http://www.sslug.dk/locale/man-sider/"
SRC_URI="http://www.sslug.dk/locale/man-sider/manpages-da-${PV}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/man"

S=${WORKDIR}/manpages-da-${PV}

src_compile() { :; }

src_install() {
	dodir /usr/share/man
	emake install-data PREFIX="${D}"/usr/share
	dodoc AUTHORS ChangeLog
}
