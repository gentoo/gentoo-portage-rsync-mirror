# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/python-cffi/python-cffi-0.ebuild,v 1.2 2015/03/23 13:36:42 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit python-r1

DESCRIPTION="https://bpaste.net/raw/006f2714152b"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	$(python_gen_cond_dep 'dev-python/cffi[${PYTHON_USEDEP}]' 'python*')
	$(python_gen_cond_dep 'virtual/pypy' pypy)"
