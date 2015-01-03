# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lv2core/lv2core-6.0.ebuild,v 1.3 2015/01/03 14:54:09 mgorny Exp $

EAPI=4

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE='threads(+)'

inherit python-any-r1 waf-utils

DESCRIPTION="LV2 is a simple but extensible successor of LADSPA"
HOMEPAGE="http://lv2plug.in/"
SRC_URI="http://lv2plug.in/spec/${P}.tar.bz2"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="!<media-libs/slv2-0.4.2"
DOCS=( "AUTHORS" "README" "NEWS" )
