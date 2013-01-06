# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypy/pypy-1.8-r1.ebuild,v 1.4 2012/11/18 02:06:28 floppym Exp $

EAPI="4"

inherit eutils toolchain-funcs check-reqs python versionator

DESCRIPTION="PyPy is a fast, compliant alternative implementation of the Python language"
HOMEPAGE="http://pypy.org/"
SRC_URI="https://bitbucket.org/pypy/pypy/get/release-${PV}.tar.bz2 -> ${P}.tar.bz2"
SLOTVER=$(get_version_component_range 1-2 ${PV})

LICENSE="MIT"
SLOT="${SLOTVER}"
PYTHON_ABI="2.7-pypy-${SLOTVER}"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 doc examples +jit ncurses sandbox shadowstack sqlite ssl +xml"

RDEPEND=">=sys-libs/zlib-1.1.3
		virtual/libffi
		virtual/libintl
		dev-libs/expat
		bzip2? ( app-arch/bzip2 )
		ncurses? ( sys-libs/ncurses )
		sqlite? ( dev-db/sqlite:3 )
		ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"
PDEPEND="app-admin/python-updater"

pkg_pretend() {
	CHECKREQS_MEMORY="2G"
	use amd64 && CHECKREQS_MEMORY="4G"
	check-reqs_pkg_pretend
}

src_unpack() {
	default
	mv pypy-pypy-* "${S}" || die
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-elf-metadata-26a8d3fc57a7.patch"
	epatch "${FILESDIR}/${PV}-sext-instructions-02dc2f6160ee.patch"
	epatch "${FILESDIR}/1.7-scripts-location.patch"
	epatch "${FILESDIR}/pypy-1.7-distutils.unixccompiler.UnixCCompiler.runtime_library_dir_option.patch"
	epatch "${FILESDIR}/pypy-1.7-distutils-fix_handling_of_executables_and_flags.patch"
}

src_compile() {
	local conf
	if use jit; then
		conf="-Ojit"
	else
		conf="-O2"
	fi
	if use shadowstack; then
		conf+=" --gcrootfinder=shadowstack"
	fi
	if use sandbox; then
		conf+=" --sandbox"
	fi

	conf+=" ./pypy/translator/goal/targetpypystandalone.py"
	# Avoid linking against libraries disabled by use flags
	local optional_use=("bzip2" "ncurses" "ssl")
	local optional_mod=("bz2" "_minimal_curses" "_ssl")
	for ((i = 0; i < ${#optional_use[*]}; i++)); do
		if use ${optional_use[$i]};	then
			conf+=" --withmod-${optional_mod[$i]}"
		else
			conf+=" --withoutmod-${optional_mod[$i]}"
		fi
	done

	local translate_cmd="$(PYTHON -2) ./pypy/translator/goal/translate.py --batch $conf"
	echo ${_BOLD}"${translate_cmd}"${_NORMAL}
	${translate_cmd} || die "compile error"
}

src_install() {
	local INSPATH="/usr/$(get_libdir)/pypy${SLOT}"
	insinto ${INSPATH}
	doins -r include lib_pypy lib-python pypy-c
	fperms a+x ${INSPATH}/pypy-c
	dosym ../$(get_libdir)/pypy${SLOT}/pypy-c /usr/bin/pypy-c${SLOT}
	dodoc README

	if ! use sqlite; then
		rm -fr "${ED}${INSPATH}/lib-python/2.7/sqlite3"
		rm -fr "${ED}${INSPATH}/lib-python/modified-2.7/sqlite3"
		rm -f "${ED}${INSPATH}/lib_pypy/_sqlite3.py"
	fi

	# Generate Grammar and PatternGrammar pickles.
	PYTHONPATH="${ED}${INSPATH}/lib_pypy/__extensions__:${ED}${INSPATH}/lib_pypy:${ED}${INSPATH}/lib-python/modified-2.7:${ED}${INSPATH}/lib-python/2.7" "${ED}${INSPATH}/pypy-c" -c "import lib2to3.pygram, lib2to3.patcomp; lib2to3.patcomp.PatternCompiler()" || die "Generation of Grammar and PatternGrammar pickles failed"
}

src_test() {
	$(PYTHON -2) ./pypy/test_all.py --pypy=./pypy-c lib-python
}
