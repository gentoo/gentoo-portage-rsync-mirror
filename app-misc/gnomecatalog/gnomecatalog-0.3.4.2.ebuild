# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnomecatalog/gnomecatalog-0.3.4.2.ebuild,v 1.3 2011/03/27 11:59:53 nirbheek Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython"

inherit distutils eutils

DESCRIPTION="Cataloging software for CDs and DVDs."
HOMEPAGE="http://gnomecatalog.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/gconf-python:2
	dev-python/gnome-vfs-python:2
	dev-python/kaa-metadata
	dev-python/libgnome-python:2
	dev-python/pygobject:2
	>=dev-python/pygtk-2.4:2
	dev-python/pysqlite:2
	dev-python/pyvorbis
	>=gnome-base/libglade-2:2.0
	>=x11-libs/gtk+-2.4:2"
DEPEND="${RDEPEND}"

src_prepare() {
	# Fix importing from a single folder in /media
	epatch "${FILESDIR}/${P}-dbus.patch"
}
