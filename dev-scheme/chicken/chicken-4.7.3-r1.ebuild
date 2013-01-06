# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-4.7.3-r1.ebuild,v 1.1 2011/12/10 13:41:55 maksbotan Exp $

EAPI="3"

inherit eutils multilib

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
HOMEPAGE="http://www.call-cc.org/"
SRC_URI="http://code.call-cc.org/dev-snapshots/2011/08/17/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="emacs parallel-build"

DEPEND="sys-apps/texinfo
		emacs? ( virtual/emacs )"
RDEPEND="emacs? ( virtual/emacs app-emacs/scheme-complete )"

src_prepare() {
	if use "parallel-build"
	then
		epatch "${FILESDIR}"/${P}-parallel-build.patch
	fi

	#Because chicken's Upstream is in the habit of using variables that
	#portage also uses :( eg. $ARCH and $A
	for f in defaults.make Makefile.bsd Makefile.cross-linux-mingw Makefile.cygwin \
		Makefile.linux Makefile.macosx Makefile.mingw-msys Makefile.solaris \
		rules.make
	do
		sed "s,ARCH,zARCH," -i ${f} || die "sed failed"
		# bug #393561: installs /usr/lib/libchickenchicken-4.7.3.tar.gz (portage pollutes ${A} variable)
		sed 's,A\(\s?=\|)\),chicken&,p' -i ${f} || die "sed failed"
	done

	sed "s,\$(PREFIX)/lib,\$(PREFIX)/$(get_libdir)," -i defaults.make || die "sed failed"
	sed "s,\$(DATADIR)/doc,\$(SHAREDIR)/doc/${P}," -i defaults.make || die "sed failed"
}

src_compile() {
	OPTIONS="PLATFORM=linux PREFIX=/usr"
	if use "parallel-build"
	then
		ewarn "You enabled parralel-build use flag. This feature is still"
		ewarn "in testing, try without it before filing bugs"
		emake ${OPTIONS} C_COMPILER_OPTIMIZATION_OPTIONS="${CFLAGS}" \
			HOSTSYSTEM="${CBUILD}" || die "emake failed"
	else
		emake -j1 ${OPTIONS} C_COMPILER_OPTIMIZATION_OPTIONS="${CFLAGS}" \
			HOSTSYSTEM="${CBUILD}" || die "emake failed"
	fi
}

# chicken's testsuite is not runnable before install
# upstream has been notified of the issue
RESTRICT=test

src_install() {
	# still can't run make in parallel for the install target
	emake -j1 ${OPTIONS} DESTDIR="${D}" HOSTSYSTEM="${CBUILD}" install || die

	rm "${D}"/usr/share/doc/${P}/LICENSE || die
	dodoc NEWS || die
}
