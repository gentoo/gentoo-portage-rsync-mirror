# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/python-pathlib/python-pathlib-1.0.ebuild,v 1.1 2014/03/30 21:24:21 hasufell Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )
inherit python-r1

DESCRIPTION="A virtual for Python pathlib module"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep \
		"dev-python/pathlib[$(python_gen_usedep python{2_7,3_2,3_3})]" \
		python{2_7,3_2,3_3})"
