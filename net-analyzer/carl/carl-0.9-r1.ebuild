# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/carl/carl-0.9-r1.ebuild,v 1.5 2015/01/15 08:25:16 klausman Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy3)

inherit distutils-r1

DESCRIPTION="An rsync logfile analyzer"
HOMEPAGE="http://www.schwarzvogel.de/software-misc.shtml"
SRC_URI="http://www.schwarzvogel.de/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~x86"
IUSE=""

DOCS="README"
