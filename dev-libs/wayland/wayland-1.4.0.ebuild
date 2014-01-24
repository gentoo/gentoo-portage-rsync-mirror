# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wayland/wayland-1.4.0.ebuild,v 1.1 2014/01/24 20:18:05 mattst88 Exp $

EAPI=5

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}/${PN}"
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
	AUTOTOOLS_AUTORECONF=1
fi

inherit autotools-multilib toolchain-funcs $GIT_ECLASS

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="http://wayland.freedesktop.org/"

if [[ $PV = 9999* ]]; then
	SRC_URI="${SRC_PATCHES}"
	KEYWORDS=""
else
	SRC_URI="http://wayland.freedesktop.org/releases/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"

RDEPEND="dev-libs/expat[${MULTILIB_USEDEP}]
	virtual/libffi[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

src_configure() {
	local myeconfargs=(
		$(use_enable doc documentation)
	)
	if tc-is-cross-compiler ; then
		myeconfargs+=( --disable-scanner )
	fi
	if ! multilib_build_binaries; then
		myeconfargs+=( --disable-documentation )
	fi

	autotools-multilib_src_configure
}

src_test() {
	export XDG_RUNTIME_DIR="${T}/runtime-dir"
	mkdir "${XDG_RUNTIME_DIR}" || die
	chmod 0700 "${XDG_RUNTIME_DIR}" || die

	autotools-multilib_src_test
}
