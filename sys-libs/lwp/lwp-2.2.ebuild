# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lwp/lwp-2.2.ebuild,v 1.8 2007/11/26 13:14:05 corsair Exp $

inherit eutils

DESCRIPTION="Light weight process library (used by Coda).  This is NOT libwww-perl."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="http://www.coda.cs.cmu.edu/pub/lwp/src/${P}.tar.gz"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="sys-apps/grep
	sys-apps/sed
	sys-devel/libtool
	sys-devel/gcc"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Was introduced for bug #34542, not sure if still needed
	use amd64 && epatch "${FILESDIR}"/lwp-2.0-amd64.patch
}

src_install() {
	einstall || die "einstall failed."
	dodoc AUTHORS NEWS PORTING README
}
