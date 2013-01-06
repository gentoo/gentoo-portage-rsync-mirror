# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mm-align/mm-align-20120321.ebuild,v 1.1 2012/03/21 12:28:50 jlec Exp $

EAPI=4

inherit cmake-utils fortran-2

DESCRIPTION="Protein Complex Structural Alignment"
HOMEPAGE="http://zhanglab.ccmb.med.umich.edu/MM-align/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/MM-align-${PV}.tar.xz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}"/CMakeLists.txt . || die
}
