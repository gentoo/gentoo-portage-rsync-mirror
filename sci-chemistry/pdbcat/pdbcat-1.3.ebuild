# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdbcat/pdbcat-1.3.ebuild,v 1.1 2012/10/12 11:32:58 jlec Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Manipulate and process PDB files using commonly available tools such as Perl, awk, etc"
HOMEPAGE="http://www.ks.uiuc.edu/Development/MDTools/pdbcat/"
SRC_URI="http://www.ks.uiuc.edu/Development/MDTools/${PN}/files/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

PATCHES=( "${FILESDIR}"/${P}-gcc.patch )
DOCS=( README )

src_prepare() {
	cp "${FILESDIR}"/CMakeLists.txt . || die
	base_src_prepare
}
