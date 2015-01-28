# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl/cmucl-20b_p001.ebuild,v 1.5 2015/01/28 19:40:59 mgorny Exp $

EAPI=3
inherit eutils multilib toolchain-funcs

MY_PV=${PV:0:3}

DESCRIPTION="CMU Common Lisp is an implementation of ANSI Common Lisp"
HOMEPAGE="http://www.cons.org/cmucl/"
SRC_URI="http://common-lisp.net/project/cmucl/downloads/release/${MY_PV}/cmucl-src-${MY_PV}.tar.bz2
	http://common-lisp.net/project/cmucl/downloads/release/${MY_PV}/cmucl-${MY_PV}-x86-linux.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE="X source cpu_flags_x86_sse2"

RDEPEND="x11-libs/motif"
DEPEND="${RDEPEND}
		sys-devel/bc"
PDEPEND="dev-lisp/gentoo-init"

S="${WORKDIR}"

# glo_usev flagname [<if_yes> [<if_no>]]
#   If $(use FLAGNAME) return true, echo IF_YES to standard output,
#   otherwise echo IF_NO. IF_YES defaults to FLAGNAME if not specified
glo_usev() {
	if [[ $# < 1 || $# > 3 ]]; then
		echo "Usage: ${0} flag [if_yes [if_no]]"
		die "${0}: wrong number of arguments: $#"
	fi
	local if_yes="${2:-${1}}" if_no="${3}"
	if use ${1} ; then
		printf "%s" "${if_yes}"
		return 0
	else
		printf "%s" "${if_no}"
		return 1
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${MY_PV}-patch001.patch
	epatch "${FILESDIR}"/fix-man-and-doc-installation.patch
	epatch "${FILESDIR}"/${MY_PV}-execstack-fixes.patch
	epatch "${FILESDIR}"/${MY_PV}-customize-lisp-implementation-version.patch
	epatch "${FILESDIR}"/${MY_PV}-nositeinit-build.patch
}

src_compile() {
	local cmufpu=$(glo_usev cpu_flags_x86_sse2 sse2 x87)
	local cmuopts="$(glo_usev !X -u) -f ${cmufpu}"
	local buildimage="bin/lisp -core lib/cmucl/lib/lisp-${cmufpu}.core -noinit -nositeinit -batch"
	env CC="$(tc-getCC)" src/tools/build.sh -v "-gentoo-${PR}" -C "" -o "${buildimage}" ${cmuopts} || die "Cannot build the compiler"
}

src_install() {
	env MANDIR=share/man/man1 DOCDIR=share/doc/${PF} \
		src/tools/make-dist.sh -S -g -G root -O root build-4 ${MY_PV} x86 linux \
		|| die "Cannot build installation archive"
	# Necessary otherwise tar will fail
	dodir /usr
	pushd "${D}"/usr
	tar xzpf "${WORKDIR}"/cmucl-${MY_PV}-x86-linux.tar.gz \
		|| die "Cannot install main system"
	if use X ; then
		tar xzpf "${WORKDIR}"/cmucl-${MY_PV}-x86-linux.extra.tar.gz \
			|| die "Cannot install extra files"
	fi
	if use source; then
		# Necessary otherwise tar will fail
		dodir /usr/share/common-lisp/source/${PN}
		cd "${D}"/usr/share/common-lisp/source/${PN}
		tar --strip-components 1 -xzpf "${WORKDIR}"/cmucl-src-${MY_PV}.tar.gz \
			|| die "Cannot install sources"
	fi
	popd

	# Install site config file
	sed "s,@PF@,${PF},g ; s,@VERSION@,$(date +%F),g" \
		< "${FILESDIR}"/site-init.lisp.in \
		> "${D}"/usr/$(get_libdir)/cmucl/site-init.lisp \
		|| die "Cannot fix site-init.lisp"
	insinto /etc
	doins "${FILESDIR}"/cmuclrc || die "Failed to install cmuclrc"
}
