# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost-numpy/boost-numpy-0_pre20131206.ebuild,v 1.1 2013/12/06 13:06:15 heroxbd Exp $

EAPI=5

inherit cmake-multilib

DESCRIPTION="Boost.Python interface for NumPy"
HOMEPAGE="https://github.com/ndarray/Boost.NumPy"
if [ ${PV} == 9999 ]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/ndarray/Boost.NumPy.git \
		https://github.com/ndarray/Boost.NumPy.git"
else
	SRC_URI="http://dev.gentoo.org/~heroxbd/${P}.tar.xz"
fi

LICENSE="Boost-1.0"
SLOT=0
IUSE="doc examples"
KEYWORDS="~amd64"

CDEPEND="dev-python/numpy
	dev-libs/boost"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

src_install() {
	cmake-multilib_src_install

	use doc && dodoc -r libs/numpy/doc/*
	use examples && dodoc -r libs/numpy/example
}
