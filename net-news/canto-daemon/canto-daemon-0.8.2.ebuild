# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/canto-daemon/canto-daemon-0.8.2.ebuild,v 1.2 2014/11/26 16:11:58 pacho Exp $

EAPI="5"

PYTHON_COMPAT=( python{3_2,3_3,3_4} )
PYTHON_REQ_USE="xml"
inherit distutils-r1

DESCRIPTION="Daemon part of Canto-NG RSS reader"
HOMEPAGE="http://codezen.org/canto-ng/"
SRC_URI="http://codezen.org/static/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/feedparser[${PYTHON_USEDEP}]"
