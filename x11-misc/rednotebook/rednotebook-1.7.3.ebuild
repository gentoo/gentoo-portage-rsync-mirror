# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rednotebook/rednotebook-1.7.3.ebuild,v 1.1 2014/01/11 00:35:06 mattm Exp $

EAPI="4"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1 eutils distutils-r1

DESCRIPTION="A graphical journal with calendar, templates, tags, keyword searching, and export functionality"
HOMEPAGE="http://rednotebook.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="libyaml spell"

RDEPEND="dev-python/pyyaml[libyaml?]
	>=dev-python/pygtk-2.13
	>=dev-python/pywebkitgtk-1.1.5
	dev-python/chardet
	spell? ( dev-python/gtkspell-python )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	! use spell && epatch "${FILESDIR}/${PN}-1.6.5-disable-spell.patch"
	distutils_src_prepare
}
