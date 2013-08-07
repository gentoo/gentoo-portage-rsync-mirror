# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypy/pypy-9999.ebuild,v 1.2 2013/08/07 11:21:51 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy{1_9,2_0} )
inherit check-reqs eutils multilib mercurial multiprocessing \
	pax-utils python-any-r1 toolchain-funcs versionator

DESCRIPTION="A fast, compliant alternative implementation of the Python language"
HOMEPAGE="http://pypy.org/"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/pypy/${PN}"

LICENSE="MIT"
SLOT="2.1"
KEYWORDS=""
IUSE="bzip2 doc +jit ncurses sandbox shadowstack sqlite sse2"

RDEPEND=">=sys-libs/zlib-1.1.3
	virtual/libffi
	virtual/libintl
	dev-libs/expat
	dev-libs/openssl
	bzip2? ( app-arch/bzip2 )
	ncurses? ( sys-libs/ncurses )
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	${PYTHON_DEPS}"
PDEPEND="app-admin/python-updater"

pkg_pretend() {
	CHECKREQS_MEMORY="2G"
	use amd64 && CHECKREQS_MEMORY="4G"
	check-reqs_pkg_pretend
#	if [[ ${MERGE_TYPE} != binary && "$(gcc-version)" == "4.8" ]]; then
#		die "PyPy does not build correctly with GCC 4.8"
#	fi
}

pkg_setup() {
	pkg_pretend
	python-any-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/1.9-scripts-location.patch"
	epatch "${FILESDIR}/1.9-distutils.unixccompiler.UnixCCompiler.runtime_library_dir_option.patch"

	epatch_user
}

src_compile() {
	tc-export CC

	local jit_backend
	if use jit; then
		jit_backend='--jit-backend='

		# We only need the explicit sse2 switch for x86.
		# On other arches we can rely on autodetection which uses
		# compiler macros. Plus, --jit-backend= doesn't accept all
		# the modern values...

		if use x86; then
			if use sse2; then
				jit_backend+=x86
			else
				jit_backend+=x86-without-sse2
			fi
		else
			jit_backend+=auto
		fi
	fi

	local args=(
		$(usex jit -Ojit -O2)
		$(usex shadowstack --gcrootfinder=shadowstack '')
		$(usex sandbox --sandbox '')

		${jit_backend}
		--make-jobs=$(makeopts_jobs)

		pypy/goal/targetpypystandalone
	)

	# Avoid linking against libraries disabled by use flags
	local opts=(
		bzip2:bz2
		ncurses:_minimal_curses
	)

	local opt
	for opt in "${opts[@]}"; do
		local flag=${opt%:*}
		local mod=${opt#*:}

		args+=(
			$(usex ${flag} --withmod --withoutmod)-${mod}
		)
	done

	set -- "${PYTHON}" rpython/bin/rpython --batch "${args[@]}"
	echo -e "\033[1m${@}\033[0m"
	"${@}" || die "compile error"

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
	dodoc README.rst

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

	# Generate cffi cache
	"${PYTHON}" -c "import _curses" || die "Failed to import _curses"
	if use sqlite; then
		"${PYTHON}" -c "import _sqlite3" || die "Failed to import _sqlite3"
	fi

	# compile the installed modules
	python_optimize "${ED%/}${INSDESTTREE}"
}
