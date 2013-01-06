# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/arandr/arandr-0.1.6.ebuild,v 1.3 2012/11/21 12:36:00 ago Exp $

EAPI=3

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils

DESCRIPTION="A simple visual frontend for XRandR 1.2/1.3"
HOMEPAGE="http://christian.amsuess.com/tools/arandr/"
SRC_URI="http://christian.amsuess.com/tools/${PN}/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2
	x11-apps/xrandr"
DEPEND=">=dev-python/docutils-0.6"

PYTHON_MODNAME=screenlayout
