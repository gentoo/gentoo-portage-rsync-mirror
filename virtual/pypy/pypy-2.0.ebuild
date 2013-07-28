# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pypy/pypy-2.0.ebuild,v 1.2 2013/07/28 09:18:55 mgorny Exp $

EAPI=5

inherit versionator

DESCRIPTION="A virtual for PyPy Python implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT=$(get_version_component_range 1-2 ${PV})
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="bzip2 ncurses sqlite"

RDEPEND="
	|| (
		dev-python/pypy:${SLOT}[bzip2?,ncurses?,sqlite?,ssl(+)]
		dev-python/pypy-bin:${SLOT}[sqlite?]
	)"
