# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dwarves/dwarves-9999.ebuild,v 1.8 2011/11/06 01:49:41 flameeyes Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/acmel/dwarves.git"
#EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/acme/pahole.git"

inherit multilib cmake-utils git-2

DESCRIPTION="pahole (Poke-a-Hole) and other DWARF2 utilities"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=summary"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND=">=dev-libs/elfutils-0.131
	sys-libs/zlib"
DEPEND="${RDEPEND}"

DOC=( README README.ctracer )

src_configure() {
	local mycmakeargs=( "-D__LIB=$(get_libdir)" )
	cmake-utils_src_configure
}

src_test() { :; }
