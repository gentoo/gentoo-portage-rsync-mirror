# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/prover9/prover9-2009.11a.ebuild,v 1.2 2012/01/08 15:01:39 gienah Exp $

EAPI="4"

inherit base versionator

MY_PN="LADR"
typeset -u MY_PV
MY_PV=$(replace_all_version_separators '-')
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Prover9 is an automated theorem prover for first-order and equational logic"
HOMEPAGE="http://www.cs.unm.edu/~mccune/mace4/"
SRC_URI="http://www.cs.unm.edu/~mccune/mace4/download/${MY_P}.tar.gz
		http://dev.gentoo.org/~gienah/2big4tree/sci-mathematics/prover9/${MY_PN}-2009-11A-makefile.patch.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="examples"

RDEPEND=""
DEPEND="$RDEPEND"

PATCHES=("${DISTDIR}/${MY_PN}-2009-11A-makefile.patch.bz2"
	"${FILESDIR}/${MY_PN}-2009-11A-manpages.patch")

src_compile() {
	emake all -j1 || die "make failed"
}

src_install () {
	dobin bin/attack || die "install attack failed"
	dobin bin/autosketches4 || die "install autosketches4 failed"
	dobin bin/clausefilter || die "install clausefilter failed"
	dobin bin/clausetester || die "install clausetester failed"
	dobin bin/complex || die "install complex failed"
	dobin bin/directproof || die "install directproof failed"
	dobin bin/dprofiles || die "install dprofiles failed"
	dobin bin/fof-prover9 || die "install fof-prover9 failed"
	dobin bin/gen_trc_defs || die "install gen_trc_defs failed"
	dobin bin/get_givens || die "install get_givens failed"
	dobin bin/get_interps || die "install get_interps failed"
	dobin bin/get_kept || die "install get_kept failed"
	dobin bin/gvizify || die "install gvizify failed"
	dobin bin/idfilter || die "install idfilter failed"
	dobin bin/interpfilter || die "install interpfilter failed"
	dobin bin/interpformat || die "install interpformat failed"
	dobin bin/isofilter || die "install isofilter failed"
	dobin bin/isofilter0 || die "install isofilter0 failed"
	dobin bin/isofilter2 || die "install isofilter2 failed"
	dobin bin/ladr_to_tptp || die "install ladr_to_tptp failed"
	dobin bin/latfilter || die "install latfilter failed"
	dobin bin/looper || die "install looper failed"
	dobin bin/mace4 || die "install mace4 failed"
	dobin bin/miniscope || die "install miniscope failed"
	dobin bin/mirror-flip || die "install mirror-flip failed"
	dobin bin/newauto || die "install newauto failed"
	dobin bin/newsax || die "install newsax failed"
	dobin bin/olfilter || die "install olfilter failed"
	dobin bin/perm3 || die "install perm3 failed"
	dobin bin/proof3fo.xsl || die "install proof3fo.xsl failed"
	dobin bin/prooftrans || die "install prooftrans failed"
	dobin bin/prover9 || die "install prover9 failed"
	dobin bin/renamer || die "install renamer failed"
	dobin bin/rewriter || die "install rewriter failed"
	dobin bin/sigtest || die "install sigtest failed"
	dobin bin/test_clause_eval || die "install test_clause_eval failed"
	dobin bin/test_complex || die "install test_complex failed"
	dobin bin/tptp_to_ladr || die "install tptp_to_ladr failed"
	dobin bin/unfast || die "install unfast failed"
	dobin bin/upper-covers || die "install upper-covers failed"

	doman manpages/interpformat.1 || die "install interpformat.1 failed"
	doman manpages/isofilter.1 || die "install isofilter.1 failed"
	doman manpages/prooftrans.1  || die "install prooftrans.1 failed"
	doman manpages/mace4.1 || die "install prooftrans.1 failed"
	doman manpages/prover9.1  || die "install prooftrans.1 failed"
	doman manpages/clausefilter.1 || die "install doman manpages/clausefilter.1 failed"
	doman manpages/clausetester.1 || die "install manpages/clausetester.1 failed"
	doman manpages/interpfilter.1 || die "install manpages/interpfilter.1 failed"
	doman manpages/rewriter.1 || die "install manpages/rewriter.1 failed"
	doman manpages/prover9-apps.1 || die "install manpages/prover9-apps.1 failed"

	dohtml ladr/index.html.master ladr/html/* || die "install html doc failed"

	insinto /usr/$(get_libdir)
	dolib.so ladr/.libs/libladr.so.4.0.0 \
		|| die "install libladr.so.4.0.0 failed"
	dosym libladr.so.4.0.0 /usr/$(get_libdir)/libladr.so.4 || die "install libladr.so.4 failed"
	dosym libladr.so.4.0.0 /usr/$(get_libdir)/libladr.so \
		 || die "install libladr.so failed"

	dodir /usr/include/ladr
	insinto /usr/include/ladr
	doins ladr/*.h || die "install header files failed"

	if use examples; then
		dodir /usr/share/${PN}/examples
		insinto /usr/share/${PN}/examples
		doins prover9.examples/*

		# The prover9-mace4 script is installed as an example script
		# to avoid confusion with the GUI sci-mathematics/p9m4 prover9mace4.py
		dodir /usr/share/${PN}/scripts
		insinto /usr/share/${PN}/scripts
		doins bin/prover9-mace4 || die "install prover9-mace4 failed"
	fi
}

S="${WORKDIR}/${MY_P}/"
