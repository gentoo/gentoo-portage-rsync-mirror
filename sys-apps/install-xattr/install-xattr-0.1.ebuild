# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/install-xattr/install-xattr-0.1.ebuild,v 1.9 2014/05/31 21:05:37 zlogene Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Wrapper to coreutil's install to preserve Filesystem Extended Attributes."
HOMEPAGE="http://dev.gentoo.org/~blueness/install-xattr/"
SRC_URI="http://dev.gentoo.org/~blueness/install-xattr/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

S=${WORKDIR}/${PN}

src_prepare() {
	tc-export CC
}

# We need to fix how tests are done
src_test() {
	true
}
