# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypy/pypy-2.0_beta1.ebuild,v 1.3 2013/01/02 04:41:23 floppym Exp $

EAPI=5

# XXX: test other implementations
PYTHON_COMPAT=( python2_7 pypy{1_8,1_9,2_0} )
inherit check-reqs eutils multilib multiprocessing python-any-r1 toolchain-funcs vcs-snapshot versionator

DESCRIPTION="A fast, compliant alternative implementation of the Python language"
HOMEPAGE="http://pypy.org/"
SRC_URI="https://bitbucket.org/pypy/pypy/get/release-${PV/_beta/-beta-}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT=$(get_version_component_range 1-2 ${PV})
KEYWORDS="~amd64 ~amd64-linux ~x86 ~x86-linux"
IUSE="bzip2 doc examples +jit ncurses sandbox shadowstack sqlite ssl +xml"

RDEPEND=">=sys-libs/zlib-1.1.3
	virtual/libffi
	virtual/libintl
	dev-libs/expat
	bzip2? ( app-arch/bzip2 )
	ncurses? ( sys-libs/ncurses )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"
PDEPEND="app-admin/python-updater"

pkg_pretend() {
	CHECKREQS_MEMORY="2G"
	use amd64 && CHECKREQS_MEMORY="4G"
	check-reqs_pkg_pretend
}

pkg_setup() {
	pkg_pretend
	python-any-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/1.9-scripts-location.patch"
	epatch "${FILESDIR}/1.9-distutils.unixccompiler.UnixCCompiler.runtime_library_dir_option.patch"
	epatch "${FILESDIR}/2.0-distutils-fix_handling_of_executables_and_flags.patch"

	# The following is Gentoo-specific.
	epatch "${FILESDIR}/2.0-no-static-hack.patch"
}

src_compile() {
	local args=(
		$(usex jit -Ojit -O2)
		$(usex shadowstack --gcrootfinder=shadowstack '')
		$(usex sandbox --sandbox '')

		--make-jobs=$(makeopts_jobs)

		./pypy/translator/goal/targetpypystandalone.py
	)

	# Avoid linking against libraries disabled by use flags
	local opts=(
		bzip2:bz2
		ncurses:_minimal_curses
		ssl:_ssl
	)

	local opt
	for opt in "${opts[@]}"; do
		local flag=${opt%:*}
		local mod=${opt#*:}

		args+=(
			$(usex ${flag} --withmod --withoutmod)-${mod}
		)
	done

	set -- "${PYTHON}" ./pypy/translator/goal/translate.py --batch "${args[@]}"
	echo -e "\033[1m${@}\033[0m"
	"${@}" || die "compile error"
}

src_install() {
	local INSDESTTREE=/usr/$(get_libdir)/pypy${SLOT}
	doins -r include lib_pypy lib-python pypy-c
	fperms a+x ${INSDESTTREE}/pypy-c
	dosym ../$(get_libdir)/pypy${SLOT}/pypy-c /usr/bin/pypy-c${SLOT}
	dodoc README

	if ! use sqlite; then
		rm -fr "${ED}${INSDESTTREE}"/lib-python/{2.7,modified-2.7}/sqlite3
		rm -f "${ED}${INSDESTTREE}"/lib_pypy/_sqlite3.py
	fi

	python_export pypy-c${SLOT} EPYTHON PYTHON PYTHON_SITEDIR

	# if not using a cross-compiler, use the fresh binary
	if ! tc-is-cross-compiler; then
		local PYTHON=${ED}${INSDESTTREE}/pypy-c
	fi

	# Generate Grammar and PatternGrammar pickles.
	PYTHONPATH="${ED}${INSDESTTREE}/lib-python/2.7" \
		"${PYTHON}" -c "import lib2to3.pygram, lib2to3.patcomp; lib2to3.patcomp.PatternCompiler()" \
		|| die "Generation of Grammar and PatternGrammar pickles failed"

	# compile the installed modules
	python_optimize "${ED}${INSDESTTREE}"

	echo "EPYTHON='${EPYTHON}'" > epython.py
	python_domodule epython.py
}

src_test() {
	"${PYTHON}" ./pypy/test_all.py --pypy=./pypy-c lib-python
}
