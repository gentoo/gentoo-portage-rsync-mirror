# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rednotebook/rednotebook-1.2.0.ebuild,v 1.3 2012/01/28 15:00:37 phajdan.jr Exp $

EAPI="3"

PYTHON_DEPEND="2"
inherit python eutils distutils

DESCRIPTION="A graphical journal with calendar, templates, tags, keyword searching, and export functionality"
HOMEPAGE="http://rednotebook.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libyaml spell"

RDEPEND="dev-python/pyyaml[libyaml?]
	>=dev-python/pygtk-2.13
	dev-python/pywebkitgtk
	spell? ( dev-python/gtkspell-python )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	! use spell && epatch "${FILESDIR}/${P}-disable-spell.patch"
	distutils_src_prepare
}
