# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/Macaulay2/Macaulay2-1.6.ebuild,v 1.3 2013/07/27 14:58:13 tomka Exp $

EAPI=5

inherit autotools elisp-common eutils flag-o-matic python-utils-r1 toolchain-funcs

IUSE="debug emacs optimization"

# Those packages will be built internally.
FACTORY="factory-3-1-6"
LIBFAC="libfac-3-1-6"
GITHUBTAG="release-1.6-stable-20130514"

DESCRIPTION="Research tool for commutative algebra and algebraic geometry"
HOMEPAGE="http://www.math.uiuc.edu/Macaulay2/"
SRC_URI="https://github.com/Macaulay2/M2/archive/${GITHUBTAG}.tar.gz -> ${P}.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Libfac/${LIBFAC}.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Factory/factory-gftables.tar.gz
	http://www.math.uiuc.edu/Macaulay2/Downloads/OtherSourceCode/trunk/${FACTORY}.tar.gz
	http://www.math.uiuc.edu/Macaulay2/Extra/gtest-1.6.0.tar.gz
	http://www.mathematik.uni-osnabrueck.de/normaliz/Normaliz2.10.1/Normaliz2.10.1.zip"
# Need normaliz for an up to date normaliz.m2

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="
	sys-process/time
	virtual/pkgconfig
	app-arch/unzip
	app-text/dos2unix
	dev-lang/python:2.7"
# Unzip and dos2unix just for normaliz
# python2.7 necessary for gtest building

RDEPEND="
	sys-libs/gdbm
	dev-libs/ntl
	sci-mathematics/pari[gmp]
	>=sys-libs/readline-6.1
	dev-libs/libxml2:2
	sci-mathematics/frobby
	sci-mathematics/4ti2
	sci-mathematics/nauty
	>=sci-mathematics/normaliz-2.10
	sci-mathematics/gfan
	sci-libs/mpir[cxx]
	dev-libs/mpfr
	sci-libs/cdd+
	sci-libs/cddlib
	sci-libs/lrslib[gmp]
	virtual/blas
	virtual/lapack
	dev-util/ctags
	sys-libs/ncurses
	>=dev-libs/boehm-gc-7.2_alpha6[threads]
	>=dev-libs/libatomic_ops-7.2_alpha6
	emacs? ( virtual/emacs )"

SITEFILE=70Macaulay2-gentoo.el

S="${WORKDIR}/M2-${GITHUBTAG}/M2"

pkg_setup () {
		tc-export CC CPP CXX
		append-cppflags "-I/usr/include/frobby"
		# gtest needs python:2. Setting it with python_export preserves
		# the exported variables in other phases too.
		python_export python2_7
}

src_prepare() {
	tc-export PKG_CONFIG
	# Put updated Normaliz.m2 in place
	cp "${WORKDIR}/Normaliz2.10/Macaulay2/Normaliz.m2" \
		"${S}/Macaulay2/packages" || die
	dos2unix "${S}/Macaulay2/packages/Normaliz.m2" || die

	# Patching .m2 files to look for external programs in
	# /usr/bin
	epatch "${FILESDIR}"/${PV}-paths-of-external-programs.patch

	# Shortcircuit lapack tests
	epatch "${FILESDIR}"/${PV}-lapack.patch

	# NumericalAlgebraicGeometry has some non-working examples (they are
	# non-reduced although that is a precondition for the used
	# algorithms.)  We just cut them.
	pushd Macaulay2/packages/NumericalAlgebraicGeometry
	epatch "${FILESDIR}"/${PV}-prune-NumAlgGeo-examples.patch
	popd

	# Factory, and libfac are statically linked libraries which (in this
	# flavor) are not used by any other program. We build them
	# internally and don't install them
	mkdir "${S}/BUILD/tarfiles" || die "Creation of directory failed"
	cp "${DISTDIR}/${FACTORY}.tar.gz" "${S}/BUILD/tarfiles/" \
		|| die "copy failed"
	cp "${DISTDIR}/factory-gftables.tar.gz" "${S}/BUILD/tarfiles/" \
		|| die "copy failed"
	cp "${DISTDIR}/${LIBFAC}.tar.gz" "${S}/BUILD/tarfiles/" \
		|| die "copy failed"
	# Macaulay2 developers want that gtest is built internally because
	# the documentation says it may fail if build with options not the
	# same as the tested program.
	cp "${DISTDIR}/gtest-1.6.0.tar.gz" "${S}/BUILD/tarfiles/" \
		|| die "copy failed"

	eautoreconf
}

src_configure (){
	# Recommended in bug #268064 Possibly unecessary
	# but should not hurt anybody.
	if ! use emacs; then
		tags="ctags"
	fi

	# configure instead of econf to enable install with --prefix
	./configure LIBS="$($(tc-getPKG_CONFIG) --libs lapack)" \
		--prefix="${D}/usr" \
		--disable-encap \
		--disable-strip \
		$(use_enable optimization optimize) \
		$(use_enable debug) \
		--enable-build-libraries="factory libfac" \
		--with-unbuilt-programs="4ti2 gfan normaliz nauty cddplus lrslib" \
		|| die "failed to configure Macaulay"
}

src_compile() {
	# Parallel build not supported yet
	emake -j1

	if use emacs; then
		cd "${S}/Macaulay2/emacs"
		elisp-compile *.el
	fi
}

src_test() {
	# No parallel tests yet & Need to increase the time
	# limit for long running tests in Schubert2 to pass
	emake TLIMIT=650 -j1 check
}

src_install () {
	# Parallel install not supported yet
	emake -j1 install

	# Remove emacs files and install them in the
	# correct place if use emacs
	rm -rf "${D}"/usr/share/emacs/site-lisp
	if use emacs; then
		cd "${S}/Macaulay2/emacs"
		elisp-install ${PN} *.elc *.el
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
		elog "If you want to set a hot key for Macaulay2 in Emacs add a line similar to"
		elog "(global-set-key [ f12 ] 'M2)"
		elog "in order to set it to F12 (or choose a different one)."
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
