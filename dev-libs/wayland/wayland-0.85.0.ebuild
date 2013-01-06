# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wayland/wayland-0.85.0.ebuild,v 1.5 2012/06/14 23:17:12 ssuominen Exp $

EAPI=4

EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}/${PN}"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
	EXPERIMENTAL="true"
fi

inherit autotools toolchain-funcs $GIT_ECLASS

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="http://wayland.freedesktop.org/"

if [[ $PV = 9999* ]]; then
	SRC_URI="${SRC_PATCHES}"
else
	SRC_URI="http://wayland.freedesktop.org/releases/${P}.tar.xz"
fi

LICENSE="CCPL-Attribution-ShareAlike-3.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/expat
	virtual/libffi"
DEPEND="${RDEPEND}"

src_prepare() {
	if [[ ${PV} = 9999* ]]; then
		eautoreconf
	fi
}

src_configure() {
	if tc-is-cross-compiler ; then
		econf $(use_enable static-libs static) --disable-scanner
	else
		econf $(use_enable static-libs static)
	fi
}
