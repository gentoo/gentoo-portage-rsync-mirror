# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxychains/proxychains-3.1_p20110225-r1.ebuild,v 1.4 2012/12/26 18:08:01 jdhore Exp $

EAPI=4
AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="http://proxychains.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="static-libs"

DEPEND="app-arch/xz-utils"
RDEPEND="net-dns/bind-tools"

PATCHES=(
	"${FILESDIR}"/${P}-glibc214.patch
	"${FILESDIR}"/${P}-sysconf.patch
)
