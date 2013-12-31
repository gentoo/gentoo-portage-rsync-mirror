# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-6.2_p5.ebuild,v 1.2 2013/12/25 23:46:50 vapier Exp $

EAPI="4"

inherit eutils multilib toolchain-funcs flag-o-matic

# Official patches
# See ftp://ftp.cwru.edu/pub/bash/readline-6.2-patches/
PLEVEL=${PV##*_p}
MY_PV=${PV/_p*}
MY_PV=${MY_PV/_/-}
MY_P=${PN}-${MY_PV}
[[ ${PV} != *_p* ]] && PLEVEL=0
patches() {
	[[ ${PLEVEL} -eq 0 ]] && return 1
	local opt=$1
	eval set -- {1..${PLEVEL}}
	set -- $(printf "${PN}${MY_PV/\.}-%03d " "$@")
	if [[ ${opt} == -s ]] ; then
		echo "${@/#/${DISTDIR}/}"
	else
		local u
		for u in ftp://ftp.cwru.edu/pub/bash mirror://gnu/${PN} ; do
			printf "${u}/${PN}-${MY_PV}-patches/%s " "$@"
		done
	fi
}

DESCRIPTION="Another cute console display library"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz $(patches)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE="static-libs"

RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
}

src_prepare() {
	[[ ${PLEVEL} -gt 0 ]] && epatch $(patches -s)
	epatch "${FILESDIR}"/${PN}-5.0-no_rpath.patch
	epatch "${FILESDIR}"/${PN}-5.2-no-ignore-shlib-errors.patch #216952
	epatch "${FILESDIR}"/${PN}-6.2-rlfe-tgoto.patch #385091

	# Force ncurses linking. #71420
	# Use pkg-config to get the right values. #457558
	sed -i \
		-e "s:^SHLIB_LIBS=:SHLIB_LIBS='$($(tc-getPKG_CONFIG) ncurses --libs)':" \
		support/shobj-conf || die

	# fix building under Gentoo/FreeBSD; upstream FreeBSD deprecated
	# objformat for years, so we don't want to rely on that.
	sed -i -e '/objformat/s:if .*; then:if true; then:' support/shobj-conf || die

	ln -s ../.. examples/rlfe/readline # for local readline headers
}

src_configure() {
	# fix implicit decls with widechar funcs
	append-cppflags -D_GNU_SOURCE
	# http://lists.gnu.org/archive/html/bug-readline/2010-07/msg00013.html
	append-cppflags -Dxrealloc=_rl_realloc -Dxmalloc=_rl_malloc -Dxfree=_rl_free

	# Force the test since we used sed above to force it.
	export bash_cv_termcap_lib=ncurses

	# Make sure configure picks a better ar than `ar`. #484866
	tc-export AR

	# This is for rlfe, but we need to make sure LDFLAGS doesn't change
	# so we can re-use the config cache file between the two.
	append-ldflags -L.
	econf \
		--cache-file="${S}"/config.cache \
		--with-curses \
		$(use_enable static-libs static)

	if ! tc-is-cross-compiler ; then
		# code is full of AC_TRY_RUN()
		cd examples/rlfe
		econf --cache-file="${S}"/config.cache
	fi
}

src_compile() {
	emake

	if ! tc-is-cross-compiler ; then
		# code is full of AC_TRY_RUN()
		cd examples/rlfe
		local l
		for l in readline history ; do
			ln -s ../../shlib/lib${l}$(get_libname)* lib${l}$(get_libname)
			ln -sf ../../lib${l}.a lib${l}.a
		done
		emake
	fi
}

src_install() {
	default
	gen_usr_ldscript -a readline history #4411

	if ! tc-is-cross-compiler; then
		dobin examples/rlfe/rlfe
	fi

	dodoc USAGE
	docinto ps
	dodoc doc/*.ps
	dohtml -r doc
}

pkg_preinst() {
	preserve_old_lib /$(get_libdir)/lib{history,readline}.so.{4,5} #29865
}

pkg_postinst() {
	preserve_old_lib_notify /$(get_libdir)/lib{history,readline}.so.{4,5}
}
