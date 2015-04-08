# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/pythia/pythia-6.4.24.ebuild,v 1.10 2012/11/30 22:08:58 bicatali Exp $

EAPI=2

inherit autotools fortran-2 versionator

MV=$(get_major_version)
MY_PN=${PN}${MV}
DOC_PV=0613
EX_PV=6.4.18

DESCRIPTION="Lund Monte Carlo high-energy physics event generator"
HOMEPAGE="http://pythia6.hepforge.org/"

# pythia6 from root is needed for some files to interface pythia6 with root.
# To produce a split version on mirror do, replace the 6.4.x by the current version
# svn export http://svn.hepforge.org/pythia6/tags/v_6_4_x/ pythia-6.4.x
# tar cjf pythia-6.4.x.tar.bz2
SRC_URI="
	mirror://gentoo/${P}.tar.bz2
	ftp://root.cern.ch/root/pythia6.tar.gz
	doc? ( http://home.thep.lu.se/~torbjorn/pythia/lutp${DOC_PV}man2.pdf )
	examples? ( mirror://gentoo/${PN}-${EX_PV}-examples.tar.bz2 )"

SLOT="6"
LICENSE="public-domain"
KEYWORDS="amd64 x86"
IUSE="doc examples static-libs"

src_prepare() {
	cp ../pythia6/tpythia6_called_from_cc.F .
	cp ../pythia6/pythia6_common_address.c .
	cat > configure.ac <<-EOF
		AC_INIT(${PN},${PV})
		AM_INIT_AUTOMAKE
		AC_PROG_F77
		AC_PROG_LIBTOOL
		AC_CHECK_LIB(m,sqrt)
		AC_CONFIG_FILES(Makefile)
		AC_OUTPUT
	EOF
	echo >> Makefile.am "lib_LTLIBRARIES = libpythia6.la"
	echo >> Makefile.am "libpythia6_la_SOURCES = \ "
	# replace wildcard from makefile to ls in shell
	for f in py*.f struct*.f up*.f fh*.f; do
		echo  >> Makefile.am "  ${f} \\"
	done
	echo  >> Makefile.am "  ssmssm.f sugra.f visaje.f pdfset.f \\"
	echo  >> Makefile.am "  tpythia6_called_from_cc.F pythia6_common_address.c"
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc update_notes.txt README
	insinto /usr/share/doc/${PF}/
	if use doc; then
		doins "${DISTDIR}"/lutp${DOC_PV}man2.pdf || die
	fi
	if use examples; then
		doins -r "${WORKDIR}"/examples || die
	fi
}
