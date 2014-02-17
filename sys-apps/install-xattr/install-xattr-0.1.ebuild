# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/install-xattr/install-xattr-0.1.ebuild,v 1.3 2014/02/17 18:25:18 blueness Exp $

EAPI=5

DESCRIPTION="Wrapper to coreutil's install to preserve Filesystem Extended Attributes."
HOMEPAGE="http://dev.gentoo.org/~blueness/install-xattr/"
SRC_URI="http://dev.gentoo.org/~blueness/install-xattr/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

# We need to fix how tests are done
src_test() {
	true
}
