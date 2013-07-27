# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypy-bin/pypy-bin-1.9.ebuild,v 1.1 2013/07/27 11:19:19 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy{1_8,1_9,2_0} )
inherit eutils multilib pax-utils python-any-r1 vcs-snapshot versionator

BINHOST="http://dev.gentoo.org/~mgorny/dist/${PN}"

DESCRIPTION="A fast, compliant alternative implementation of the Python language (binary package)"
HOMEPAGE="http://pypy.org/"
SRC_URI="https://bitbucket.org/pypy/pypy/get/release-${PV}.tar.bz2 -> pypy-${PV}.tar.bz2
	amd64? (
		jit? ( shadowstack? (
			${BINHOST}/${P}-amd64+bzip2+jit+ncurses+shadowstack.tar.xz
		) )
		jit? ( !shadowstack? (
			${BINHOST}/${P}-amd64+bzip2+jit+ncurses.tar.xz
		) )
		!jit? ( !shadowstack? (
			${BINHOST}/${P}-amd64+bzip2+ncurses.tar.xz
		) )
	)
	x86? (
		sse2? (
			jit? ( shadowstack? (
				${BINHOST}/${P}-x86+bzip2+jit+ncurses+shadowstack+sse2.tar.xz
			) )
			jit? ( !shadowstack? (
				${BINHOST}/${P}-x86+bzip2+jit+ncurses+sse2.tar.xz
			) )
			!jit? ( !shadowstack? (
				${BINHOST}/${P}-x86+bzip2+ncurses+sse2.tar.xz
			) )
		)
		!sse2? (
			!jit? ( !shadowstack? (
				${BINHOST}/${P}-x86+bzip2+ncurses.tar.xz
			) )
		)
	)"

# Supported variants
REQUIRED_USE="!jit? ( !shadowstack )
	x86? ( !sse2? ( !jit !shadowstack ) )"

LICENSE="MIT"
SLOT=$(get_version_component_range 1-2 ${PV})
KEYWORDS="~amd64 ~x86"
IUSE="doc +jit shadowstack sqlite sse2 test"

RDEPEND="
	~app-arch/bzip2-1.0.6
	~dev-libs/expat-2.1.0
	|| ( ~dev-libs/libffi-3.0.13
		~dev-libs/libffi-3.0.12
		~dev-libs/libffi-3.0.11 )
	|| ( ~dev-libs/openssl-1.0.1e
		~dev-libs/openssl-1.0.1d
		~dev-libs/openssl-1.0.1c )
	|| ( ~sys-libs/glibc-2.17
		~sys-libs/glibc-2.16.0
		~sys-libs/glibc-2.15 )
	~sys-libs/ncurses-5.9
	|| ( ~sys-libs/zlib-1.2.8
		~sys-libs/zlib-1.2.7 )
	sqlite? ( dev-db/sqlite:3 )
	!dev-python/pypy:${SLOT}"
DEPEND="doc? ( dev-python/sphinx )
	test? ( ${RDEPEND} )"
PDEPEND="app-admin/python-updater"

S=${WORKDIR}/pypy-${PV}

pkg_setup() {
	use doc && python-any-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-no-bytecode-4151f9c406b6.patch"
	epatch "${FILESDIR}/${PV}-scripts-location.patch"
	epatch "${FILESDIR}/${PV}-distutils.unixccompiler.UnixCCompiler.runtime_library_dir_option.patch"
	epatch "${FILESDIR}/${PV}-distutils-fix_handling_of_executables_and_flags.patch"
	epatch "${FILESDIR}/${PV}-ssl-threads-1-34b3b5aac082.patch"
	epatch "${FILESDIR}/${PV}-ssl-threads-2-25cd11066d95.patch"
	epatch "${FILESDIR}/${PV}-get_python_lib_standard_lib-04ea518e5b71.patch"
	epatch "${FILESDIR}/${PV}-more-ignored-ops-a9a8faa76bca.patch"
	epatch "${FILESDIR}/${PV}-more-ignored-ops-146ddf82a279.patch"
	epatch "${FILESDIR}/${PV}-pybuffer-release-double-decref-4ec2a5b49386.patch"
	epatch "${FILESDIR}/${PV}-signal-a33052b17f4e.patch"
	epatch "${FILESDIR}/${PV}-getargs-freelist-c26dc70ee340.patch"
	epatch "${FILESDIR}/${PV}-ssl-errors-25d3418150d2.patch"

	# The following is Gentoo-specific.
	epatch "${FILESDIR}/${PV}-no-static-hack.patch"

	epatch_user
}

src_compile() {
	# Tadaam! PyPy compiled!
	mv "${WORKDIR}"/${P}*/pypy-c . || die
	mv "${WORKDIR}"/${P}*/include/*.h include/ || die
	mv pypy/module/cpyext/include/*.h include/ || die

	use doc && emake -C pypy/doc/ html
}

src_test() {
	# (unset)
	local -x PYTHONDONTWRITEBYTECODE

	./pypy-c ./pypy/test_all.py --pypy=./pypy-c lib-python || die
}

src_install() {
	einfo "Installing PyPy ..."
	insinto "/usr/$(get_libdir)/pypy${SLOT}"
	doins -r include lib_pypy lib-python pypy-c
	fperms a+x ${INSDESTTREE}/pypy-c
	use jit && pax-mark m "${ED%/}${INSDESTTREE}/pypy-c"
	dosym ../$(get_libdir)/pypy${SLOT}/pypy-c /usr/bin/pypy-c${SLOT}
	dosym ../$(get_libdir)/pypy${SLOT}/include /usr/include/pypy${SLOT}
	dodoc README

	if ! use sqlite; then
		rm -r "${ED%/}${INSDESTTREE}"/lib-python/*2.7/sqlite3 || die
		rm "${ED%/}${INSDESTTREE}"/lib_pypy/_sqlite3.py || die
	fi

	# Install docs
	use doc && dohtml -r pypy/doc/_build/html/

	einfo "Generating caches and byte-compiling ..."

	python_export pypy-c${SLOT} EPYTHON PYTHON PYTHON_SITEDIR
	local PYTHON=${ED%/}${INSDESTTREE}/pypy-c

	echo "EPYTHON='${EPYTHON}'" > epython.py
	python_domodule epython.py

	# Note: call portage helpers before this line.
	# PYTHONPATH confuses them and will result in random failures.

	local -x PYTHONPATH="${ED%/}${INSDESTTREE}/lib_pypy:${ED%/}${INSDESTTREE}/lib-python/2.7"

	# Generate Grammar and PatternGrammar pickles.
	"${PYTHON}" -c "import lib2to3.pygram, lib2to3.patcomp; lib2to3.patcomp.PatternCompiler()" \
		|| die "Generation of Grammar and PatternGrammar pickles failed"

	# compile the installed modules
	python_optimize "${ED%/}${INSDESTTREE}"
}
