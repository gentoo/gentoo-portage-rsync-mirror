# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wayland/wayland-1.3.0.ebuild,v 1.4 2015/02/09 01:19:26 chithanh Exp $

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
IUSE="doc static-libs"

RDEPEND=">=dev-libs/expat-2.1.0-r3[${MULTILIB_USEDEP}]
	>=virtual/libffi-3.0.13-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

src_prepare() {
	# Remove resources-test from TESTS as it has failed since it was added.
	sed -i -e 's/	resources-test$(EXEEXT)/	$(NULL)/' "${S}"/tests/Makefile.in || die

	autotools-multilib_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable doc documentation)
	)
	if tc-is-cross-compiler ; then
		myeconfargs+=( --disable-scanner )
	fi
	if ! multilib_is_native_abi; then
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
