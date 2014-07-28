# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/perl/perl-5.18.2-r1.ebuild,v 1.3 2014/07/28 16:12:41 zlogene Exp $

EAPI=5

inherit eutils alternatives flag-o-matic toolchain-funcs multilib multiprocessing

PATCH_VER=2

PERL_OLDVERSEN="5.18.0 5.18.1"
MODULE_AUTHOR=RJBS

SHORT_PV="${PV%.*}"
MY_P="perl-${PV/_rc/-RC}"
MY_PV="${PV%_rc*}"

DESCRIPTION="Larry Wall's Practical Extraction and Report Language"

SRC_URI="
	mirror://cpan/src/5.0/${MY_P}.tar.bz2
	mirror://cpan/authors/id/${MODULE_AUTHOR:0:1}/${MODULE_AUTHOR:0:2}/${MODULE_AUTHOR}/${MY_P}.tar.bz2
	mirror://gentoo/${MY_P}-patches-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~civil/distfiles/${CATEGORY}/${PN}/${MY_P}-patches-${PATCH_VER}.tar.bz2
"
HOMEPAGE="http://www.perl.org/"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0/${SHORT_PV}"
KEYWORDS="alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="berkdb debug doc gdbm ithreads"

RDEPEND="
	berkdb? ( sys-libs/db )
	gdbm? ( >=sys-libs/gdbm-1.8.3 )
	app-arch/bzip2
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	!prefix? ( elibc_FreeBSD? ( sys-freebsd/freebsd-mk-defs ) )
"
PDEPEND=">=app-admin/perl-cleaner-2.5"

S="${WORKDIR}/${MY_P}"

dual_scripts() {
	src_remove_dual      perl-core/Archive-Tar        1.820.0      ptar ptardiff ptargrep
	src_remove_dual      perl-core/Digest-SHA         5.710.0      shasum
	src_remove_dual      perl-core/CPAN               1.980.0      cpan
	src_remove_dual      perl-core/CPANPLUS           0.912.100    cpanp cpan2dist
	src_remove_dual_file perl-core/CPANPLUS           0.912.100    /usr/bin/cpanp-run-perl
	src_remove_dual      perl-core/Encode             2.440.0      enc2xs piconv
	src_remove_dual      perl-core/ExtUtils-MakeMaker 6.630.200_rc instmodsh
	src_remove_dual      perl-core/ExtUtils-ParseXS   3.160.0      xsubpp
	src_remove_dual      perl-core/IO-Compress        2.48.0       zipdetails
	src_remove_dual      perl-core/JSON-PP            2.272.0      json_pp
	src_remove_dual      perl-core/Module-Build       0.390.100_rc config_data
	src_remove_dual      perl-core/Module-CoreList    2.840.0      corelist
	src_remove_dual      perl-core/PodParser          1.510.0      pod2usage podchecker podselect
	src_remove_dual      perl-core/Pod-Perldoc        1.170.0      perldoc
	src_remove_dual      perl-core/Test-Harness       3.230.0      prove
	src_remove_dual      perl-core/podlators          2.4.0        pod2man pod2text
	src_remove_dual_man  perl-core/podlators          2.4.0        /usr/share/man/man1/perlpodstyle.1
}

# eblit-include [--skip] <function> [version]
eblit-include() {
	local skipable=false
	[[ $1 == "--skip" ]] && skipable=true && shift
	[[ $1 == pkg_* ]] && skipable=true

	local e v func=$1 ver=$2
	[[ -z ${func} ]] && die "Usage: eblit-include <function> [version]"
	for v in ${ver:+-}${ver} -${PVR} -${PV} "" ; do
		e="${FILESDIR}/eblits/${func}${v}.eblit"
		if [[ -e ${e} ]] ; then
			. "${e}"
			return 0
		fi
	done
	${skipable} && return 0
	die "Could not locate requested eblit '${func}' in ${FILESDIR}/eblits/"
}

# eblit-run-maybe <function>
# run the specified function if it is defined
eblit-run-maybe() {
	[[ $(type -t "$@") == "function" ]] && "$@"
}

# eblit-run <function> [version]
# aka: src_unpack() { eblit-run src_unpack ; }
eblit-run() {
	eblit-include --skip common "${*:2}"
	eblit-include "$@"
	eblit-run-maybe eblit-$1-pre
	eblit-${PN}-$1
	eblit-run-maybe eblit-$1-post
}

#src_unpack()	{ eblit-run src_unpack    v50160001 ; }
src_prepare()	{ eblit-run src_prepare   v50160001 ; }
src_configure()	{ eblit-run src_configure v50180002 ; }
#src_compile()	{ eblit-run src_compile   v50160001 ; }
src_test()		{ eblit-run src_test      v50160001 ; }
src_install()	{ eblit-run src_install   v50160001 ; }

# FILESDIR might not be available during binpkg install
# FIXME: version passing
for x in setup {pre,post}{inst,rm} ; do
	e="${FILESDIR}/eblits/pkg_${x}-v50160001.eblit"
	if [[ -e ${e} ]] ; then
		. "${e}"
		eval "pkg_${x}() { eblit-run pkg_${x} v50160001 ; }"
	fi
done
