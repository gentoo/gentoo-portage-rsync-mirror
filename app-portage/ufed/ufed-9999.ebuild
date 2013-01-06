# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-9999.ebuild,v 1.1 2012/11/20 18:22:58 fuzzyray Exp $

EAPI=4

inherit eutils multilib git-2 autotools prefix

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/ufed.git"

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_prepare() {
	# Change the version number to reflect the ebuild version
	sed -i "s:,\[git\],:,\[9999-${EGIT_VERSION}\],:" configure.ac
	eprefixify ufed.8
	eautoreconf
}

src_configure() {
	econf --libexecdir="${EPREFIX}"/usr/$(get_libdir)/ufed
}
