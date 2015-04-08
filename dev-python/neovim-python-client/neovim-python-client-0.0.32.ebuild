# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/neovim-python-client/neovim-python-client-0.0.32.ebuild,v 1.1 2015/03/29 04:08:05 yngwin Exp $

EAPI=5
#PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )
PYTHON_COMPAT=( python2_7 ) # currently only works on py2
inherit distutils-r1

DESCRIPTION="Python client to connect to Neovim thru its msgpack-rpc API"
HOMEPAGE="https://github.com/neovim/python-client"
SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/click-3.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.4.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/greenlet[${PYTHON_USEDEP}]' 'python*')
	$(python_gen_cond_dep 'dev-python/trollius[${PYTHON_USEDEP}]' python{2_7,3_3} 'pypy*')"
RDEPEND="${DEPEND}"
