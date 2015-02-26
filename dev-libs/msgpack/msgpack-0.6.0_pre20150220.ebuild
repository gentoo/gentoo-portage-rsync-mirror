# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/msgpack/msgpack-0.6.0_pre20150220.ebuild,v 1.3 2015/02/26 06:16:37 yngwin Exp $

EAPI=5
inherit cmake-multilib

DESCRIPTION="MessagePack is a binary-based efficient data interchange format"
HOMEPAGE="http://msgpack.org/ https://github.com/msgpack/msgpack-c/"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}-c.git"
	KEYWORDS=""
else
	SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="static-libs test"

DEPEND="test? ( >=dev-cpp/gtest-1.6.0-r2[${MULTILIB_USEDEP}] )"
DOCS=( CHANGELOG.md QUICKSTART-C.md QUICKSTART-CPP.md README.md CROSSLANG.md )
