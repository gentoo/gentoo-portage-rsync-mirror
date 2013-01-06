# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.4.7.ebuild,v 1.32 2012/05/08 10:27:47 xarthisius Exp $

EAPI=1

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="documentation system for C++, C, Java, Objective-C, Python, IDL, and other languages"
HOMEPAGE="http://www.doxygen.org/"
SRC_URI="http://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz
	http://dev.gentoo.org/~xarthisius/distfiles/doxywizard.png
	unicode? ( mirror://gentoo/${P}-utf8-ru.patch.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc latex unicode"

RDEPEND=">=media-gfx/graphviz-2.6
	latex? ( app-text/texlive-core
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-genericrecommended
		dev-texlive/texlive-fontsrecommended )
	app-text/ghostscript-gpl"
DEPEND=">=sys-apps/sed-4
	${RDEPEND}"

EPATCH_SUFFIX="patch"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# still needs patch for Russian text in source files (see bug #112076)
	if use unicode; then
		epatch "${WORKDIR}/${P}-utf8-ru.patch" || die "utf8-ru patch failed"
	fi

	# use CFLAGS, CXXFLAGS, LDFLAGS
	sed -i.orig -e 's:^\(TMAKE_CFLAGS_RELEASE\t*\)= .*$:\1= $(ECFLAGS):' \
		-e 's:^\(TMAKE_CXXFLAGS_RELEASE\t*\)= .*$:\1= $(ECXXFLAGS):' \
		-e 's:^\(TMAKE_LFLAGS_RELEASE\s*\)=.*$:\1= $(ELDFLAGS):' \
		tmake/lib/{{linux,freebsd,netbsd,openbsd,solaris}-g++,macosx-c++}/tmake.conf

	# Consolidate patches, apply FreeBSD configure patch, codepage patch,
	# qtools stuff, and patches for bugs 129142, 121770, and 129560.
	epatch "${FILESDIR}/${PV}"

	if is-flagq "-O3" ; then
		echo
		ewarn "Compiling with -O3 is known to produce incorrectly"
		ewarn "optimized code which breaks doxygen."
		echo
		epause 6
		elog "Continuing with -O2 instead ..."
		echo
		replace-flags "-O3" "-O2"
	fi
}

src_compile() {
	export ECFLAGS="${CFLAGS}" ECXXFLAGS="${CXXFLAGS}" ELDFLAGS="${LDFLAGS}"
	# set ./configure options (prefix, Qt based wizard, docdir)
	local my_conf="--prefix ${D}usr"
	./configure ${my_conf} || die 'configure failed'

	# and compile
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" \
		LINK_SHLIB="$(tc-getCXX)" all || die 'emake failed'

	# generate html and pdf (if tetex in use) documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		if use tetex; then
			addwrite /var/cache/fonts
			addwrite /usr/share/texmf/fonts/pk
			addwrite /usr/share/texmf/ls-R
			make pdf || ewarn '"make pdf docs" failed.'
		else
			cp doc/Doxyfile doc/Doxyfile.orig
			cp doc/Makefile doc/Makefile.orig
			sed -i.orig -e "s/GENERATE_LATEX    = YES/GENERATE_LATEX    = NO/" doc/Doxyfile
			sed -i.orig -e "s/@epstopdf/# @epstopdf/" \
				-e "s/@cp Makefile.latex/# @cp Makefile.latex/" \
				-e "s/@sed/# @sed/" doc/Makefile
			make docs || ewarn '"make html docs" failed.'
		fi
	fi
}

src_install() {
	make DESTDIR="${D}" MAN1DIR=share/man/man1 \
		install || die '"make install" failed.'

	dodoc INSTALL LANGUAGE.HOWTO README

	# pdf and html manuals
	if use doc; then
		insinto /usr/share/doc/${PF}
		if use tetex; then
			doins latex/doxygen_manual.pdf
		fi
		dohtml -r html/*
	fi
}

pkg_postinst() {
	elog
	elog "The USE flags doc, and tetex will enable "
	elog "the html and pdf documentation, respectively.  For examples"
	elog "and other goodies, see the source tarball.  For some example"
	elog "output, run doxygen on the doxygen source using the Doxyfile"
	elog "provided in the top-level source dir."
	elog
	elog "See the Doxygen homepage for additional language support tools."
	elog
}
