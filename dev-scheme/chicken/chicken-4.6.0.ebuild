# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-4.6.0.ebuild,v 1.1 2010/10/06 04:25:05 chiiph Exp $

EAPI="3"

inherit eutils multilib

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
HOMEPAGE="http://www.call-with-current-continuation.org/"
SRC_URI="http://code.call-cc.org/releases/4.6.0/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="emacs"

DEPEND="sys-apps/texinfo
		emacs? ( virtual/emacs )"
RDEPEND="emacs? ( virtual/emacs app-emacs/scheme-complete )"

src_prepare() {
	#Because chicken's Upstream have a custom to use variables that also
	#portage uses :( eg. $ARCH in this case
	for f in defaults.make Makefile.bsd Makefile.cross-linux-mingw Makefile.cygwin \
		Makefile.linux Makefile.macosx Makefile.mingw-msys Makefile.solaris \
		rules.make
		do
			sed "s,ARCH,zARCH," -i ${f} || die "sed failed"
		done

	sed "s,\$(PREFIX)/lib,\$(PREFIX)/$(get_libdir)," -i defaults.make || die "sed failed"
	sed "s,\$(DATADIR)/doc,\$(SHAREDIR)/doc/${P}," -i defaults.make || die "sed failed"
}

src_compile() {
	OPTIONS="PLATFORM=linux PREFIX=/usr"
	#upstream does not support parallel builds, bug 265881
	emake -j1 ${OPTIONS} C_COMPILER_OPTIMIZATION_OPTIONS="${CFLAGS}" \
		HOSTSYSTEM="${CBUILD}" || die "emake failed"
}

# chicken's testsuite is not runnable before install
# upstream has been notified of the issue
RESTRICT=test

src_install() {
	# bug #283158
	emake -j1 ${OPTIONS} DESTDIR="${D}" HOSTSYSTEM="${CBUILD}" install || die

	rm "${D}"/usr/share/doc/${P}/LICENSE || die
	dodoc NEWS || die
}
