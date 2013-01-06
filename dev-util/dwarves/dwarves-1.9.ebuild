# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dwarves/dwarves-1.9.ebuild,v 1.1 2011/10/17 21:53:24 flameeyes Exp $

EAPI=4

inherit multilib cmake-utils

DESCRIPTION="pahole (Poke-a-Hole) and other DWARF2 utilities"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=summary"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=dev-libs/elfutils-0.131
	sys-libs/zlib"
DEPEND="${RDEPEND}"

if [[ ${PV//_p} == ${PV} ]]; then
	SRC_URI="http://fedorapeople.org/~acme/dwarves/${P}.tar.bz2"
	S=${WORKDIR}
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
fi

DOCS=( README README.ctracer NEWS )

src_configure() {
	local mycmakeargs=( "-D__LIB=$(get_libdir)" )
	cmake-utils_src_configure
}

src_test() { :; }
