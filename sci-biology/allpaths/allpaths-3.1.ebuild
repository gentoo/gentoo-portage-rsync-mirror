# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/allpaths/allpaths-3.1.ebuild,v 1.4 2012/11/19 10:27:46 jlec Exp $

EAPI=4

inherit base

DESCRIPTION="De novo assembly of whole-genome shotgun microreads"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd"
SRC_URI="
	ftp://ftp.broad.mit.edu/pub/crd/ALLPATHS/Release-3-0/allpaths-${PV}.tgz
	ftp://ftp.broad.mit.edu/pub/crd/ALLPATHS/Release-3-0/AllPathsV3_Manual_r1.0.docx"

LICENSE="Whitehead-MIT"
SLOT="3"
IUSE=""
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/AllPaths"

DEPEND="!sci-biology/allpathslg"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-gcc4.7.patch )

src_prepare() {
	sed \
		-e "s:-O3:${CXXFLAGS}:g" \
		-e 's:-ggdb3::g' \
		-i Makefile* || die
	base_src_prepare
}

src_compile() {
	base_src_compile
	emake install_scripts
}

src_install() {
	exeinto /usr/libexec/${P}/
	find bin -type f -executable | xargs doexe || die

	echo "PATH=\"/usr/libexec/${P}/\"" > "${S}/50${P}"
	doenvd "${S}/50${P}" || die

	dosym /usr/libexec/${P}/RunAllPaths3G /usr/bin/RunAllPaths3G

	dodoc "${DISTDIR}/AllPathsV3_Manual_r1.0.docx"
}
