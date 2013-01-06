# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/consed/consed-19-r1.ebuild,v 1.4 2012/10/24 19:30:07 ulm Exp $

EAPI=1

inherit toolchain-funcs

DESCRIPTION="Consed: a genome sequence finishing program"
HOMEPAGE="http://bozeman.mbt.washington.edu/consed/consed.html"
SRC_URI="${P}-sources.tar.gz
	${P}-linux.tar.gz"

LICENSE="phrap"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/motif-2.3:0"
RDEPEND="${DEPEND}
	>=sci-biology/phred-000925
	>=sci-biology/phrap-1.080721"

S="${WORKDIR}"

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE} and obtain the file"
	einfo "\"sources.tar.gz\", then rename it to \"${P}-sources.tar.gz\""
	einfo "and place it in ${DISTDIR},"
	einfo "obtain the file"
	einfo "\"consed_linux.tar.gz\", then rename it to \"${P}-linux.tar.gz\""
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	sed -i '/#include/ s/<new.h>/<new>/' "${S}/main.cpp" || die
	sed -i -e '/CLIBS=/ s/$/ -lXm -lXt -lSM -lICE -lXext -lXmu -lXp -lm/' \
		-e 's/ARCHIVES=/ARCHIVES=\n_ARCHIVES=/' \
		-e 's/CFLGS=/CFLGS= ${CFLAGS} /' "${S}/makefile" || die
	sed -i -e 's/CFLAGS=/CFLAGS += /' "${S}"/misc/*/Makefile || die
	sed -i 's!\($szPhredParameterFile =\).*!\1 $ENV{PHRED_PARAMETER_FILE} || "/usr/share/phred/phredpar.dat";!' "${S}/scripts/"* || die
}

src_compile() {
	emake || die
	emake -C misc/mktrace || die
	emake -C misc/phd2fasta || die
	(cd misc/454; $(tc-getCC) ${CFLAGS} sff2scf.c -o sff2scf) || die
}

src_install() {
	dobin consed misc/{mktrace/mktrace,phd2fasta/phd2fasta,454/sff2scf} || die
	dobin scripts/* contributions/* || die
	insinto /usr/lib/screenLibs
	doins misc/*.{fa*,seq}
	insinto /usr/share/${PN}/examples
	doins -r standard polyphred autofinish assembly_view 454_newbler \
		align454reads align454reads_answer solexa_example \
		solexa_example_answer selectRegions selectRegionsAnswer || die
	echo 'CONSED_HOME=/usr' > "${S}/99consed"
	doenvd "${S}/99consed" || die
	dodoc README.txt *_announcement.txt
}

pkg_postinst() {
	einfo "Package documentation is available at"
	einfo "http://www.phrap.org/consed/distributions/README.${PV}.0.txt"
}
