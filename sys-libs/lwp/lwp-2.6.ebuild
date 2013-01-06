# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lwp/lwp-2.6.ebuild,v 1.3 2013/01/03 22:37:34 vapier Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Light weight process library (used by Coda).  This is NOT libwww-perl."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="http://www.coda.cs.cmu.edu/pub/lwp/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_prepare() {
	# Was introduced for bug #34542, not sure if still needed
	use amd64 && epatch "${FILESDIR}"/lwp-2.0-amd64.patch
}
