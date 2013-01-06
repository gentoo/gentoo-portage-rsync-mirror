# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect/expect-5.43.0-r1.ebuild,v 1.3 2010/04/23 10:44:12 jlec Exp $

EAPI="3"

WANT_AUTOCONF="2.1"
inherit autotools eutils multilib versionator

DESCRIPTION="tool for automating interactive applications"
HOMEPAGE="http://expect.nist.gov/"
SRC_URI="http://expect.nist.gov/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="doc X"

# We need dejagnu for src_test, but dejagnu needs expect
# to compile/run, so we cant add dejagnu to DEPEND :/
DEPEND=">=dev-lang/tcl-8.2
	X? ( >=dev-lang/tk-8.2 )"
RDEPEND="${DEPEND}"

NON_MICRO_V=${PN}-$(get_version_component_range 1-2)
S=${WORKDIR}/${NON_MICRO_V}

src_prepare() {
	# fix install_name on darwin
	[[ ${CHOST} == *-darwin* ]] && \
		epatch "${FILESDIR}"/${P}-darwin.patch
	epatch "${FILESDIR}"/"${P}"-multilib.patch

	#fix the rpath being set to /var/tmp/portage/...
	epatch "${FILESDIR}"/expect-5.39.0-libdir.patch

	#Removes references to functions that Tcl 8.5 no longer exposes.
	epatch "${FILESDIR}"/"${P}"-avoid-tcl-internals-1.patch

	sed -i "s#/usr/local/bin#${EPREFIX}/usr/bin#" expect.man
	sed -i "s#/usr/local/bin#${EPREFIX}/usr/bin#" expectk.man
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

#	epatch "${FILESDIR}"/"${P}"-ldflags.patch

	eautoconf
}

src_configure() {
	local myconf
	local tcl_version
	tcl_version="$(best_version dev-lang/tcl | cut -d- -f3 | cut -d. -f1,2)"
	TCL_HDIR="${EPREFIX}/usr/$(get_libdir)/tcl${tcl_version}/include"
	#configure needs to find the file tclConfig.sh is
	myconf="--with-tcl=${EPREFIX}/usr/$(get_libdir) --with-tclinclude=${TCL_HDIR}"

	if use X ; then
		#--with-x is enabled by default
		#configure needs to find the file tkConfig.sh and tk.h
		#tk.h is in /usr/lib so don't need to explicitly set --with-tkinclude
		myconf="$myconf --with-tk=/usr/$(get_libdir)"
	else
		#configure knows that tk depends on X so just disable X
		myconf="$myconf --without-x"
	fi

	econf $myconf --enable-shared
}

src_compile() {
	emake TCLHDIRDASHI="-I${TCL_HDIR}/generic -I${TCL_HDIR}/unix" \
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

	dodoc ChangeLog FAQ HISTORY NEWS README || die

	local lib_basename="lib${NON_MICRO_V/-/}"
	rm "${ED}/usr/$(get_libdir)/${NON_MICRO_V/-/}/${lib_basename}.a"

	# bug #182278 - /usr/lib/expect.so symlink
	ln -s "${lib_basename}.so" "${ED}/usr/$(get_libdir)/lib${PN}.so"

	#install examples if 'doc' is set
	if use doc ; then
		docinto examples
		local scripts=$(make -qp | \
		                sed -e 's/^SCRIPTS = //' -et -ed | head -n1)
		insinto /usr/share/doc/${PF}/examples
		doins ${scripts} || die
		local scripts_manpages=$(make -qp | \
		       sed -e 's/^_SCRIPTS_MANPAGES = //' -et -ed | head -n1)
		for m in ${scripts_manpages}; do
			dodoc example/${m}.man
		done
		dodoc example/README
	fi
}
