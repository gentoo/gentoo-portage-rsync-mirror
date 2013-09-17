# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gourmet/gourmet-0.16.1.ebuild,v 1.1 2013/09/17 03:23:26 patrick Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="Recipe Organizer and Shopping List Generator for Gnome"
HOMEPAGE="http://thinkle.github.com/gourmet/"
SRC_URI="https://github.com/thinkle/gourmet/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-print pdf rtf"

RDEPEND=">=dev-python/pygtk-2.3.93:2
	dev-python/pygobject:2
	>=dev-python/libgnome-python-2
	>=gnome-base/libglade-2
	dev-python/sqlalchemy
	!=dev-python/sqlalchemy-0.6.4
	dev-python/pillow
	dev-python/gtkspell-python
	dev-python/python-distutils-extra
	dev-db/metakit[python]
	pdf? ( dev-python/reportlab dev-python/python-poppler )
	rtf? ( dev-python/pyrtf )
	gnome-print? ( dev-python/libgnomeprint-python
	               dev-python/python-poppler )"
DEPEND="${RDEPEND}"

# distutils gets a bunch of default docs
DOCS=( TESTS FAQ )

src_prepare() {
	distutils-r1_src_prepare
	sed -i "s:base_dir = '..':base_dir = '/usr/share':" gourmet/settings.py || die
	sed -i 's:data_dir = os.path.join(base_dir, "gourmet", "data"):data_dir = os.path.join(base_dir, "gourmet"):' gourmet/settings.py || die
}

src_install() {
	distutils-r1_src_install
	doman gourmet.1
}
