# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-gtk/bzr-gtk-0.100.0.ebuild,v 1.6 2012/09/30 18:38:37 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="/${P/_rc/rc}"

DESCRIPTION="A GTK+ interfaces to most Bazaar operations"
HOMEPAGE="http://bazaar-vcs.org/bzr-gtk"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gconf gnome-keyring gpg +sourceview nautilus"

DEPEND=">=dev-vcs/bzr-1.6_rc1
	dev-python/pygtk:2
	dev-python/notify-python
	>=dev-python/pycairo-1.0"
RDEPEND="${DEPEND}
	nautilus? ( <dev-python/nautilus-python-1.0 !>=gnome-base/nautilus-3.0 )
	dev-python/notify-python
	gnome-keyring? ( dev-python/gnome-keyring-python )
	gpg? ( app-crypt/seahorse )
	sourceview? (
		dev-python/pygtksourceview:2
		gconf? ( dev-python/gconf-python:2 )
	)"

S="${WORKDIR}/${MY_P}"

#TODO: src_test

src_prepare() {
	# Remove after release of > 0.99.0
	cp "${FILESDIR}"/credits.pickle "${S}"/credits.pickle
}

src_install() {
	distutils_src_install
	insinto /etc/xdg/autostart
	doins bzr-notify.desktop
	if ! use nautilus
	then
		rm -rf "${D}"/usr/lib/nautilus/
		rm -rf "${D}"/usr/lib/python2.7/site-packages/bzrlib/plugins/gtk/nautilus-bzr.py
	fi
}
