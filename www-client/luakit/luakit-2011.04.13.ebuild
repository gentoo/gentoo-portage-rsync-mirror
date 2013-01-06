# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/luakit/luakit-2011.04.13.ebuild,v 1.3 2012/12/04 11:33:43 wired Exp $

EAPI=3

IUSE="luajit vim-syntax"

if [[ ${PV} == *9999* ]]; then
	inherit git
	EGIT_REPO_URI=${EGIT_REPO_URI:-"git://github.com/mason-larobina/luakit.git"}
	[[ ${EGIT_BRANCH} == "master" ]] && EGIT_BRANCH="develop"
	[[ ${EGIT_COMMIT} == "master" ]] && EGIT_COMMIT=${EGIT_BRANCH}
	KEYWORDS=""
	SRC_URI=""
else
	inherit base
	MY_PV="${PV/_p/-r}"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://github.com/mason-larobina/${PN}/tarball/${MY_PV} -> ${P}.tar.gz"
fi

DESCRIPTION="fast, small, webkit-gtk based micro-browser extensible by lua"
HOMEPAGE="http://mason-larobina.github.com/luakit/"

LICENSE="GPL-3"
SLOT="0"

COMMON_DEPEND="
	luajit? ( dev-lang/luajit:2 )
	!luajit? ( >=dev-lang/lua-5.1 )
	dev-db/sqlite:3
	dev-libs/glib:2
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
"

DEPEND="
	virtual/pkgconfig
	sys-apps/help2man
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	dev-lua/luafilesystem
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
"

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		git_src_prepare
	else
		cd "${WORKDIR}"/mason-larobina-luakit-*
		S=$(pwd)
		base_src_prepare
	fi
}

src_compile() {
	myconf="PREFIX=/usr DEVELOPMENT_PATHS=0"
	use luajit && myconf+=" USE_LUAJIT=1"

	if [[ ${PV} != *9999* ]]; then
		myconf+=" VERSION=${PV}"
	fi

	emake ${myconf} || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" install ||
		die "Installation failed"

	if use vim-syntax; then
		local t
		for t in $(ls "${S}"/extras/vim/); do
			insinto /usr/share/vim/vimfiles/"${t}"
			doins "${S}"/extras/vim/"${t}"/luakit.vim ||
				die "vim-${t} doins failed"
		done
	fi
}
