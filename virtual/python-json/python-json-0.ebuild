# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/python-json/python-json-0.ebuild,v 1.4 2013/09/05 13:56:50 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )
inherit python-r1

DESCRIPTION="A virtual for JSON support in Python, with simplejson fallback"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

# Every in-tree Python has JSON built-in.
RDEPEND="${PYTHON_DEPS}"
