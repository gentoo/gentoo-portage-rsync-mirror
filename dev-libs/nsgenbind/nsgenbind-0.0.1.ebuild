# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nsgenbind/nsgenbind-0.0.1.ebuild,v 1.2 2013/06/23 16:46:30 xmw Exp $

EAPI=5
NETSURF_COMPONENT_TYPE=binary

inherit netsurf

DESCRIPTION="generate javascript to dom bindings from w3c webidl files"
HOMEPAGE="http://www.netsurf-browser.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

DEPEND="virtual/yacc"

PATCHES=( "${FILESDIR}"/${P}-bison-2.6.patch )
