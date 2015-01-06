# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/conque/conque-2.3-r1.ebuild,v 1.1 2015/01/06 12:34:46 mgorny Exp $

EAPI="4"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
VIM_PLUGIN_VIM_VERSION="7.1"

inherit python-single-r1 vim-plugin

MY_P="${PN}_${PV}"
DESCRIPTION="vim plugin: Run interactive commands inside a Vim buffer"
HOMEPAGE="http://code.google.com/p/conque/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( app-editors/vim[python,${PYTHON_USEDEP}] app-editors/gvim[python,${PYTHON_USEDEP}] )
	${PYTHON_DEPS}"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

VIM_PLUGIN_HELPFILES="ConqueTerm"

S="${WORKDIR}/${MY_P}"
