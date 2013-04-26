# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-user-dirs/xdg-user-dirs-0.14.ebuild,v 1.13 2013/04/26 10:12:45 ssuominen Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="A tool to help manage 'well known' user directories"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/xdg-user-dirs"
SRC_URI="http://user-dirs.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="gtk nls"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"
PDEPEND="gtk? (
	nls? ( x11-misc/xdg-user-dirs-gtk )
	)"

DOCS=( AUTHORS ChangeLog NEWS )

src_prepare() {
	sed -i -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die #467032
	epatch "${FILESDIR}"/${P}-strndup-nls.patch
	eautoreconf # for the above patch
}

src_configure() {
	econf $(use_enable nls)
}
