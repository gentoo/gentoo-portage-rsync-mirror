# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mopac7/mopac7-1.10-r1.ebuild,v 1.8 2012/10/19 10:00:39 jlec Exp $

WANT_AUTOMAKE="1.8"

inherit autotools fortran-2

DESCRIPTION="Autotooled, updated version of a powerful, fast semi-empirical package"
HOMEPAGE="http://sourceforge.net/projects/mopac7/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

SLOT="0"
LICENSE="mopac7"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="dev-libs/libf2c"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Install the executable
	sed -i \
		-e "s:noinst_PROGRAMS = mopac7:bin_PROGRAMS = mopac7:g" \
		src/Makefile.am \
		|| die "sed failed: install mopac7"
	# Install the script to run the executable
	sed -i \
		-e "s:EXTRA_DIST = run_mopac7:if HAVE_F2C\nbin_SCRIPTS = run_mopac7\nendif:g" \
		Makefile.am \
		|| die "sed failed: install run_mopac7"

	# Fix parallel build by adding internal dependency on libmopac7.la from
	# executable
	sed -i \
		-e "s:mopac7_LDFLAGS = -lmopac7 -lf2c -lm:mopac7_LDFLAGS = -lf2c -lm:g" \
		-e "s:\(mopac7_LDFLAGS.*\):\1\nmopac7_LDADD = libmopac7.la:g" \
		src/Makefile.am \
		|| die "sed failed: fix dependencies"

	eautoreconf
}

src_install() {
	# A correct fix would have a run_mopac7.in with @bindir@ that gets
	# replaced by configure, and run_mopac7 added to AC_OUTPUT in configure.ac
	sed -i "s:./src/mopac7:mopac7:g" run_mopac7

	make DESTDIR="${D}" install || die
	dodoc AUTHORS README ChangeLog || die
}
