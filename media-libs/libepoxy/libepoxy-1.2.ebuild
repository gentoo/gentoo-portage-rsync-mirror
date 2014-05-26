# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libepoxy/libepoxy-1.2.ebuild,v 1.2 2014/05/26 12:08:37 chithanh Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=yes

EGIT_REPO_URI="git://github.com/anholt/libepoxy.git"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
fi

inherit autotools-multilib ${GIT_ECLASS}

DESCRIPTION="Epoxy is a library for handling OpenGL function pointer management for you"
HOMEPAGE="https://github.com/anholt/libepoxy"
if [[ ${PV} = 9999* ]]; then
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~amd64 ~arm ~x86"
	SRC_URI="https://github.com/anholt/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTICT="test" # FIXME: tests fail when run from portage.

DEPEND="dev-lang/python
	x11-misc/util-macros
	x11-libs/libX11"
RDEPEND=""

src_unpack() {
	default
	[[ $PV = 9999* ]] && git-r3_src_unpack
}
