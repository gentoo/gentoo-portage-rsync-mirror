# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwapcaplet/libwapcaplet-0.2.0.ebuild,v 1.2 2013/06/23 16:42:19 xmw Exp $

EAPI=5

inherit netsurf

DESCRIPTION="string internment library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libwapcaplet/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="test"

REQUIRED_USE="amd64? ( abi_x86_32? ( !test ) )"

DEPEND="test? ( dev-libs/check )"
