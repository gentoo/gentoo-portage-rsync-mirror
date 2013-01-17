# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-4.8.0.ebuild,v 1.1 2013/01/17 22:22:13 pchrist Exp $

EAPI="3"

inherit eutils multilib

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
HOMEPAGE="http://www.call-cc.org/"
SRC_URI="http://code.call-cc.org/releases/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="emacs parallel-build"

DEPEND="sys-apps/texinfo
		emacs? ( virtual/emacs )"
RDEPEND="emacs? ( virtual/emacs app-emacs/scheme-complete )"

# chicken's testsuite is not runnable before install
# upstream has been notified of the issue
RESTRICT=test

src_prepare() {
	if use "parallel-build"
	then
		epatch "${FILESDIR}"/${P}-parallel-build.patch
	fi

	#Because chicken's Upstream is in the habit of using variables that
	#portage also uses :( eg. $ARCH and $A
	sed 's,A\(\s?=\|)\),chicken&,' -i Makefile.cross-linux-mingw \
		defaults.make rules.make \
		|| die "sed failed"

	sed "s,ARCH,zARCH," -i Makefile.bsd Makefile.cross-linux-mingw \
		Makefile.cygwin Makefile.haiku Makefile.linux Makefile.macosx \
		Makefile.mingw Makefile.mingw-msys Makefile.solaris \
		defaults.make rules.make \
		|| die "sed failed"

	sed "s,\$(PREFIX)/lib,\$(PREFIX)/$(get_libdir)," -i defaults.make || die "sed failed"
	sed "s,\$(DATADIR)/doc,\$(SHAREDIR)/doc/${P}," -i defaults.make || die "sed failed"
}

src_compile() {
	OPTIONS="PLATFORM=linux PREFIX=/usr"
	if use "parallel-build"
	then
		emake ${OPTIONS} C_COMPILER_OPTIMIZATION_OPTIONS="${CFLAGS}" \
			LINKER_OPTIONS="${LDFLAGS}" \
			HOSTSYSTEM="${CBUILD}" || die "emake failed"
	else
		emake -j1 ${OPTIONS} C_COMPILER_OPTIMIZATION_OPTIONS="${CFLAGS}" \
			LINKER_OPTIONS="${LDFLAGS}" \
			HOSTSYSTEM="${CBUILD}" || die "emake failed"
	fi
}

src_install() {
	# still can't run make in parallel for the install target
	emake -j1 ${OPTIONS} DESTDIR="${D}" HOSTSYSTEM="${CBUILD}" \
		LINKER_OPTIONS="${LDFLAGS}" \
		install || die

	rm "${D}"/usr/share/doc/${P}/LICENSE || die
	dodoc NEWS || die
}
