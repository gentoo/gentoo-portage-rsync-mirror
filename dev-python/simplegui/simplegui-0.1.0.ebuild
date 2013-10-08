# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplegui/simplegui-0.1.0.ebuild,v 1.1 2013/10/08 20:35:16 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="tk"

inherit distutils-r1

DESCRIPTION="Simplified GUI generation using Tkinter"
HOMEPAGE="http://florian-berger.de/en/software/simplegui"
SRC_URI="http://static.florian-berger.de/simplegui-0.1.0.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/cx_Freeze[${PYTHON_USEDEP}]"
