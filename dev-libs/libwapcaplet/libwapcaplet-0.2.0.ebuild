# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwapcaplet/libwapcaplet-0.2.0.ebuild,v 1.3 2014/01/05 19:04:33 grobian Exp $

EAPI=5

inherit netsurf

DESCRIPTION="string internment library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libwapcaplet/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~m68k-mint"
IUSE="test"

REQUIRED_USE="amd64? ( abi_x86_32? ( !test ) )"

DEPEND="test? ( dev-libs/check )"
