# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libhubbub/libhubbub-0.2.0.ebuild,v 1.2 2013/06/23 16:44:07 xmw Exp $

EAPI=5

inherit netsurf

DESCRIPTION="HTML5 compliant parsing library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/hubbub/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="doc test"

#libjson.so.0.0.1 from app-emulation/emul-linux-x86-baselibs is outdated
REQUIRED_USE="amd64? ( abi_x86_32? ( !test ) )"

RDEPEND=">=dev-libs/libparserutils-0.1.2[static-libs?,${MULTILIB_USEDEP}]
	!net-libs/hubbub"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl
		dev-libs/json-c )"

PATCHES=( "${FILESDIR}"/${P}-error.patch )
DOCS=( README docs/{Architecture,Macros,Todo,Treebuilder,Updated} )

RESTRICT=test
