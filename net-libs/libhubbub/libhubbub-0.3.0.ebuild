# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libhubbub/libhubbub-0.3.0.ebuild,v 1.1 2014/11/06 18:17:34 xmw Exp $

EAPI=5

inherit netsurf

DESCRIPTION="HTML5 compliant parsing library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/hubbub/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~m68k-mint"
IUSE="doc test"

RDEPEND=">=dev-libs/libparserutils-0.2.0[static-libs?,${MULTILIB_USEDEP}]
	!net-libs/hubbub"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl
		>=dev-libs/json-c-0.10-r1[${MULTILIB_USEDEP}] )"

#PATCHES=( "${FILESDIR}"/${P}-error.patch )
DOCS=( README docs/{Architecture,Macros,Todo,Treebuilder,Updated} )

RESTRICT=test
