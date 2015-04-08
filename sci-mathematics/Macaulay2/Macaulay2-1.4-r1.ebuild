# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/Macaulay2/Macaulay2-1.4-r1.ebuild,v 1.5 2015/03/26 10:17:49 tomka Exp $

EAPI="2"

inherit autotools elisp-common eutils flag-o-matic

IUSE="emacs optimization"
MY_REV="12617"

FACTORYVER="3-1-1"

DESCRIPTION="research tool for commutative algebra and algebraic geometry"
SRC_BASE="http://www.math.uiuc.edu/${PN}/Downloads/"
SRC_URI="${SRC_BASE}/OtherSourceCode/1.4/factory-${FACTORYVER}.tar.gz
		 ${SRC_BASE}/OtherSourceCode/1.4/libfac-${FACTORYVER}.tar.gz
		 http://www.math.uiuc.edu/${PN}/Extra/gc-7.2alpha5-2010-09-03.tar.gz
		 ${SRC_BASE}/SourceCode/${P}-r${MY_REV}-src.tar.bz2"

HOMEPAGE="http://www.math.uiuc.edu/Macaulay2/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
# Tests are broken and building the package runs thousands of tests anyway
RESTRICT="test"

DEPEND="sys-libs/gdbm
	>=dev-libs/ntl-5.5.2
	<dev-libs/ntl-7
	>=sci-mathematics/pari-2.3.4[gmp]
	>=sys-libs/readline-6.1
	dev-libs/libxml2:2
	sci-mathematics/frobby
	sci-mathematics/4ti2
	sci-mathematics/nauty
	>=sci-mathematics/normaliz-2.5
	<sci-mathematics/normaliz-2.7
	sci-mathematics/gfan
	>=dev-libs/mpfr-3.0.0
	>=sci-libs/mpir-2.1.1[cxx]
	sci-libs/cddlib
	sci-libs/cdd+
	sci-libs/lrslib[gmp]
	virtual/blas
	virtual/lapack
	dev-util/ctags
	sys-libs/ncurses
	sys-process/time
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

SITEFILE=70Macaulay2-gentoo.el

S="${WORKDIR}/${P}-r${MY_REV}"

pkg_setup () {
		tc-export CC CPP CXX
		append-cppflags "-I/usr/include/frobby"
}

src_prepare() {
	# Patching .m2 files to look for external programs in
	# /usr/bin
	epatch "${FILESDIR}"/${PV}-paths-of-external-programs.patch

	# The following three are all upstream and need to be removed on bump.
	# Fix an incompatibility with pari-2.5
	epatch "${FILESDIR}"/${PV}-pari-2.5-compat.patch
	# Two M2.el improvements
	epatch "${FILESDIR}"/${PV}-comint-use-fields.patch
	epatch "${FILESDIR}"/${PV}-fix-emacs-syntax-table.patch

	# Fixing make warnings about unavailable jobserver:
	sed -i "s/\$(MAKE)/+ \$(MAKE)/g" "${S}"/distributions/Makefile.in

	# Factory, and libfac are statically linked libraries which (in this flavor) are not used by any
	# other program. We build them internally and don't install them
	mkdir "${S}/BUILD/tarfiles" || die "Creation of directory failed"
	cp "${DISTDIR}/factory-3-1-1.tar.gz" "${S}/BUILD/tarfiles/" \
		|| die "copy failed"
	cp "${DISTDIR}/libfac-3-1-1.tar.gz" "${S}/BUILD/tarfiles/" \
		|| die "copy failed"
	# Macaulay 2 in this version insists on a snapshot of boehm-gc that is not available elsewhere
	# We will let it build its internal version until >=boehm-gc-7.2_alpha5 is in in tree.  Note:
	# The resulting QA warning is known.
	cp "${DISTDIR}/gc-7.2alpha5-2010-09-03.tar.gz" "${S}/BUILD/tarfiles/" \
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
	./configure --prefix="${D}/usr" \
		--disable-encap \
		--disable-strip \
		$(use_enable optimization optimize) \
		--enable-build-libraries="factory gc libfac" \
		--with-unbuilt-programs="4ti2 gfan normaliz nauty cddplus lrslib" \
		|| die "failed to configure Macaulay"
}

src_compile() {
	# Parallel build not supported yet
	emake -j1 || die "failed to build Macaulay"

	if use emacs; then
		cd "${S}/Macaulay2/emacs"
		elisp-compile *.el || die "elisp-compile failed"
	fi
}

src_test() {
	emake check || die "tests failed"
}

src_install () {
	# Parallel install not supported yet
	emake -j1 install || die "install failed"

	# Remove emacs files and install them in the
	# correct place if use emacs
	rm -rf "${D}"/usr/share/emacs/site-lisp
	if use emacs; then
		cd "${S}/Macaulay2/emacs"
		elisp-install ${PN} *.elc *.el || die "elisp-install failed"
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
