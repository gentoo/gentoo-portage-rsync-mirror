# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/allpaths/allpaths-3.1-r1.ebuild,v 1.3 2013/07/17 06:17:01 jlec Exp $

EAPI=5

inherit base multilib

DESCRIPTION="De novo assembly of whole-genome shotgun microreads"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd"
SRC_URI="
	ftp://ftp.broad.mit.edu/pub/crd/ALLPATHS/Release-3-0/allpaths-${PV}.tgz
	ftp://ftp.broad.mit.edu/pub/crd/ALLPATHS/Release-3-0/AllPathsV3_Manual_r1.0.docx"

LICENSE="Whitehead-MIT"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="openmp"

DEPEND="!sci-biology/allpathslg"
RDEPEND="${DEPEND}"

S="${WORKDIR}/AllPaths"

PATCHES=(
	"${FILESDIR}"/${P}-gcc4.7.patch
	"${FILESDIR}"/${P}-boost-1.50.patch
	"${FILESDIR}"/${P}-linking.patch
	)

pkg_setup() {
	if use openmp; then
		if [[ $(tc-getCC) == *gcc ]] && ! tc-has-openmp; then
			ewarn "OpenMP is not available in your current selected gcc"
			die "need openmp capable gcc"
		fi
	fi
}

src_prepare() {
	sed \
		-e "s:-O3:${CXXFLAGS}:g" \
		-e 's:-ggdb3::g' \
		-i Makefile* || die

	if use openmp; then
		sed \
			-e '/OPEN_MP/s:no:yes:g' \
			-i Makefile.in || die
	fi
	base_src_prepare
	export L_FLAGS="${LDFLAGS}"
}

src_configure() {
	econf \
		--with-boost="${EPREFIX}/usr" \
		--with-boost-libdir="${EPREFIX}/usr/$(get_libdir)"
}

src_compile() {
	base_src_compile
	emake install_scripts
}

src_install() {
	exeinto /usr/libexec/${P}/
	find bin -type f -executable | xargs doexe

	echo "PATH=\"/usr/libexec/${P}/\"" > "${S}/50${P}"
	doenvd "${S}/50${P}" || die

	dosym /usr/libexec/${P}/RunAllPaths3G /usr/bin/RunAllPaths3G

	dodoc "${DISTDIR}/AllPathsV3_Manual_r1.0.docx"
}
