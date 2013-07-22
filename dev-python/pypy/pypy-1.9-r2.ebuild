# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypy/pypy-1.9-r2.ebuild,v 1.5 2013/07/22 06:54:59 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy{1_8,1_9,2_0} )
inherit check-reqs eutils multilib multiprocessing python-any-r1 toolchain-funcs vcs-snapshot versionator

DESCRIPTION="A fast, compliant alternative implementation of the Python language"
HOMEPAGE="http://pypy.org/"
SRC_URI="https://bitbucket.org/pypy/pypy/get/release-${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT=$(get_version_component_range 1-2 ${PV})
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
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
}

pkg_setup() {
	pkg_pretend
	python-any-r1_pkg_setup
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

		./pypy/translator/goal/targetpypystandalone.py
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

	set -- "${PYTHON}" ./pypy/translator/goal/translate.py --batch "${args[@]}"
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
	dosym ../$(get_libdir)/pypy${SLOT}/pypy-c /usr/bin/pypy-c${SLOT}
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
