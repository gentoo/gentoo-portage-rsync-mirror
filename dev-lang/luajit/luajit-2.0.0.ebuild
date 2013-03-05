# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/luajit/luajit-2.0.0.ebuild,v 1.2 2013/03/05 21:54:23 bicatali Exp $

EAPI=5

inherit eutils multilib pax-utils versionator toolchain-funcs

MY_P="LuaJIT-$(get_version_component_range 1-3)"
if [[ $(get_version_component_range 4) != "" ]]; then
	HOTFIX="$(get_version_component_range 3-4)"
	HOTFIX="${HOTFIX/_p/_hotfix}.patch"
fi

DESCRIPTION="Just-In-Time Compiler for the Lua programming language"
HOMEPAGE="http://luajit.org/"
SRC_URI="http://luajit.org/download/${MY_P}.tar.gz
	${HOTFIX:+http://luajit.org/download/${HOTFIX}}"

LICENSE="MIT"
# this should probably be pkgmoved to 2.0 for sake of consistency.
SLOT="2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare(){
	if [[ -n ${HOTFIX} ]]; then
		epatch "${DISTDIR}/${HOTFIX}"
	fi

	epatch "${FILESDIR}"/${MY_P}-gentoo.patch
	sed -i \
		-e "s:/usr:${EPREFIX}/usr:g" \
		etc/luajit.pc Makefile src/luaconf.h src/Makefile || die

}

src_compile() {
	emake \
		DESTDIR="${D}" \
		HOST_CC="$(tc-getBUILD_CC)" \
		STATIC_CC="$(tc-getCC)" \
		DYNAMIC_CC="$(tc-getCC) -fPIC" \
		TARGET_LD="$(tc-getCC)" \
		TARGET_AR="$(tc-getAR) rcus" \
		TARGET_STRIP="true" \
		LDCONFIG="true" \
		LIBDIR="$(get_libdir)"
}

src_install(){
	emake install \
		DESTDIR="${D}" \
		HOST_CC="$(tc-getBUILD_CC)" \
		STATIC_CC="$(tc-getCC)" \
		DYNAMIC_CC="$(tc-getCC) -fPIC" \
		TARGET_LD="$(tc-getCC)" \
		TARGET_AR="$(tc-getAR) rcus" \
		TARGET_STRIP="true" \
		LDCONFIG="true" \
		LIBDIR="$(get_libdir)"

	pax-mark m "${ED}usr/bin/luajit-2.0"

	cd "${S}"/doc
	dohtml -r *
}
