# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.5.8-r1.ebuild,v 1.14 2012/05/31 03:38:35 zmedico Exp $

EAPI=2

inherit eutils flag-o-matic multilib toolchain-funcs qt4-r2 fdo-mime

DESCRIPTION="documentation system for C++, C, Java, Objective-C, Python, IDL, and other languages"
HOMEPAGE="http://www.doxygen.org/"
SRC_URI="http://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz
	http://dev.gentoo.org/~xarthisius/distfiles/doxywizard.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug doc nodot qt4 latex elibc_FreeBSD"

RDEPEND="qt4? ( x11-libs/qt-gui:4 )
	latex? ( app-text/texlive-core
		dev-texlive/texlive-genericrecommended
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-latexextra )
	dev-lang/python
	virtual/libiconv
	media-libs/libpng
	app-text/ghostscript-gpl
	!nodot? ( >=media-gfx/graphviz-2.6
		media-libs/freetype )"
DEPEND=">=sys-apps/sed-4
	sys-devel/flex
	${RDEPEND}"

EPATCH_SUFFIX="patch"

src_prepare() {
	qt4-r2_src_prepare

	# use CFLAGS, CXXFLAGS, LDFLAGS
	sed -i.orig -e 's:^\(TMAKE_CFLAGS_RELEASE\t*\)= .*$:\1= $(ECFLAGS):' \
		-e 's:^\(TMAKE_CXXFLAGS_RELEASE\t*\)= .*$:\1= $(ECXXFLAGS):' \
		-e 's:^\(TMAKE_LFLAGS_RELEASE\s*\)=.*$:\1= $(ELDFLAGS):' \
		tmake/lib/{{linux,freebsd,netbsd,openbsd,solaris}-g++,macosx-c++}/tmake.conf \
		|| die "sed 1 failed"

	# Ensure we link to -liconv
	if use elibc_FreeBSD; then
		for pro in */*.pro.in */*/*.pro.in; do
		echo "unix:LIBS += -liconv" >> "${pro}"
		done
	fi

	# Consolidate patches, apply FreeBSD configure patch, codepage patch,
	# qtools stuff, and patches for bugs 129142, 121770, and 129560.
	epatch "${FILESDIR}/${PN}-1.5-legacy-patches.diff"
	# backport fix for bug #266693
	epatch "${FILESDIR}/${P}-kdedocs.patch"

	# remove internal libpng - see bug #210237
	epatch "${FILESDIR}/${PN}-1.5-system-libpng.patch"

	# fix final DESTDIR issue
	sed -i.orig -e "s:\$(INSTALL):\$(DESTDIR)/\$(INSTALL):g" \
		addon/doxywizard/Makefile.in || die "sed 2 failed"

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

src_configure() {
	export ECFLAGS="${CFLAGS}" ECXXFLAGS="${CXXFLAGS}" ELDFLAGS="${LDFLAGS}"

	# set ./configure options (prefix, Qt based wizard, docdir)
	local my_conf=""
	if use debug; then
		my_conf="--prefix /usr --debug"
	else
		my_conf="--prefix /usr"
	fi

	export CC="${QMAKE_CC}"
	export CXX="${QMAKE_CXX}"
	export LINK="${QMAKE_LINK}"
	export LINK_SHLIB="${QMAKE_CXX}"

	if use qt4; then
		export QTDIR="/usr"
		export LIBRARY_PATH="${QTDIR}/$(get_libdir):${LIBRARY_PATH}"
		export LD_LIBRARY_PATH="${QTDIR}/$(get_libdir):${LD_LIBRARY_PATH}"
		./configure ${my_conf} $(use_with qt4 doxywizard) \
		|| die 'configure with qt4 failed'
		# this appears to work as a fix for the final ignoring LDFLAGS issue...
		pushd "${S}"/addon/doxywizard
			eqmake4 "CONFIG+=nostrip" doxywizard.pro -o Makefile.doxywizard
		popd
	else
		./configure ${my_conf} || die 'configure failed'
	fi
}

src_compile() {
	# and compile
	emake all || die 'emake failed'

	# generate html and pdf (if tetex in use) documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		if use nodot; then
			sed -i -e "s/HAVE_DOT               = YES/HAVE_DOT    = NO/" \
				{Doxyfile,doc/Doxyfile} \
				|| ewarn "disabling dot failed"
		fi
		if use latex; then
			addwrite /var/cache/fonts
			addwrite /var/cache/fontconfig
			addwrite /usr/share/texmf/fonts/pk
			addwrite /usr/share/texmf/ls-R
			make pdf || ewarn '"make pdf docs" failed.'
		else
			cp doc/Doxyfile doc/Doxyfile.orig
			cp doc/Makefile doc/Makefile.orig
			sed -i.orig -e "s/GENERATE_LATEX    = YES/GENERATE_LATEX    = NO/" \
				doc/Doxyfile
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

	if use qt4; then
		doicon "${DISTDIR}/doxywizard.png"
		make_desktop_entry doxywizard "DoxyWizard ${PV}" \
			"doxywizard" "Application;Development"
	fi

	dodoc INSTALL LANGUAGE.HOWTO README

	# pdf and html manuals
	if use doc; then
		dohtml -r html/*
		if use latex; then
			insinto /usr/share/doc/"${PF}"
			doins latex/doxygen_manual.pdf
		fi
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog
	elog "The USE flags qt4, doc, and latex will enable doxywizard, or"
	elog "the html and pdf documentation, respectively.  For examples"
	elog "and other goodies, see the source tarball.  For some example"
	elog "output, run doxygen on the doxygen source using the Doxyfile"
	elog "provided in the top-level source dir."
	elog
	elog "Enabling the nodot USE flag will remove the GraphViz dependency,"
	elog "along with Doxygen's ability to generate diagrams in the docs."
	elog "See the Doxygen homepage for additional helper tools to parse"
	elog "more languages."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
