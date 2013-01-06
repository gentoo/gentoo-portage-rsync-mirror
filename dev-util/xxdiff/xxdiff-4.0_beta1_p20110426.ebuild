# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-4.0_beta1_p20110426.ebuild,v 1.6 2012/11/30 20:39:15 hwoarang Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils qt4-r2

DESCRIPTION="A graphical file and directories comparator and merge tool"
HOMEPAGE="http://furius.ca/xxdiff/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-gcc47.patch )

src_prepare() {
	pushd src >/dev/null
	sed -i -e '/qPixmapFromMimeSource/d' *.ui || die #365019
	qt4-r2_src_prepare
	popd

	distutils_src_prepare
}

src_configure() {
	pushd src >/dev/null
	qt4-r2_src_configure
	cat Makefile.extra >> Makefile
	popd
}

src_compile() {
	pushd src >/dev/null
	qt4-r2_src_compile
	popd

	distutils_src_compile
}

src_install() {
	dobin bin/xxdiff || die

	distutils_src_install

	dodoc CHANGES README* TODO doc/*.txt src/doc.txt

	dohtml doc/*.{png,html} src/doc.html

	# example tools, use these to build your own ones
	insinto /usr/share/doc/${PF}
	doins -r tools || die

	# missing EAPI=4 support in distutils.eclass, forced to use prepalldocs
	prepalldocs
}
