# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect/expect-5.43.0.ebuild,v 1.23 2010/04/16 12:07:25 jlec Exp $

WANT_AUTOCONF="2.1"
inherit autotools eutils versionator

DESCRIPTION="tool for automating interactive applications"
HOMEPAGE="http://expect.nist.gov/"
SRC_URI="http://expect.nist.gov/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="X doc"

# We need dejagnu for src_test, but dejagnu needs expect
# to compile/run, so we cant add dejagnu to DEPEND :/
DEPEND=">=dev-lang/tcl-8.2
	X? ( >=dev-lang/tk-8.2 )"
RDEPEND="${DEPEND}"

NON_MICRO_V=${PN}-$(get_version_component_range 1-2)
S=${WORKDIR}/${NON_MICRO_V}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/"${P}"-multilib.patch

	#fix the rpath being set to /var/tmp/portage/...
	epatch "${FILESDIR}"/expect-5.39.0-libdir.patch

	#Removes references to functions that Tcl 8.5 no longer exposes.
	epatch "${FILESDIR}"/"${P}"-avoid-tcl-internals-1.patch

	sed -i 's#/usr/local/bin#/usr/bin#' expect.man
	sed -i 's#/usr/local/bin#/usr/bin#' expectk.man
	#stops any example scripts being installed by default
	sed -i \
		-e '/^install:/s/install-libraries //' \
		-e 's/^SCRIPTS_MANPAGES = /_&/' \
		Makefile.in
	#fixes "TCL_REG_BOSONLY undeclared" error due to a change in tcl8.5
	sed -i -e 's/^#include "tcl.h"/#include "tclInt.h"/' \
		exp_inter.c exp_command.c
	#fix missing define of HAVE_UNISTD_H in Dbg.c
	sed -i -e 's/^\(#include <stdio\.h>\)/\1\n#include "expect_cf.h"/' \
		Dbg.c

	# fix implicit missing declarations (bug 204878)
	epatch "${FILESDIR}"/"${P}"-missing-includes.patch

	eautoconf
}

src_compile() {
	local myconf
	local tcl_version
	local tcl_hdir
	tcl_version=$(echo 'puts [set tcl_version]' | tclsh)
	tcl_hdir="/usr/$(get_libdir)/tcl${tcl_version}/include"

	#configure needs to find the file tclConfig.sh is
	myconf="--with-tcl=/usr/$(get_libdir) --with-tclinclude=$tcl_hdir"

	if use X ; then
		#--with-x is enabled by default
		#configure needs to find the file tkConfig.sh and tk.h
		#tk.h is in /usr/lib so don't need to explicitly set --with-tkinclude
		myconf="$myconf --with-tk=/usr/$(get_libdir)"
	else
		#configure knows that tk depends on X so just disable X
		myconf="$myconf --without-x"
	fi

	econf $myconf --enable-shared || die "econf failed"
	emake TCLHDIRDASHI="-I${tcl_hdir}/generic -I${tcl_hdir}/unix" \
		|| die "emake failed"
}

src_test() {
	# we need dejagnu to do tests ... but dejagnu needs
	# expect ... so don't do tests unless we have dejagnu
	type -p runtest || return 0
	make check || die "make check failed"
}

src_install() {
	dodir /usr/$(get_libdir)
	make install INSTALL_ROOT="${D}" || die "make install failed"

	dodoc ChangeLog FAQ HISTORY NEWS README

	local lib_basename="lib${NON_MICRO_V/-/}"
	rm "${D}/usr/$(get_libdir)/${NON_MICRO_V/-/}/${lib_basename}.a"

	# bug #182278 - /usr/lib/expect.so symlink
	ln -s "${lib_basename}.so" "${D}/usr/$(get_libdir)/lib${PN}.so"

	#install examples if 'doc' is set
	if use doc ; then
		docinto examples
		local scripts=$(make -qp | \
		                sed -e 's/^SCRIPTS = //' -et -ed | head -n1)
		exeinto /usr/share/doc/${PF}/examples
		doexe ${scripts}
		local scripts_manpages=$(make -qp | \
		       sed -e 's/^_SCRIPTS_MANPAGES = //' -et -ed | head -n1)
		for m in ${scripts_manpages}; do
			dodoc example/${m}.man
		done
		dodoc example/README
	fi
}
